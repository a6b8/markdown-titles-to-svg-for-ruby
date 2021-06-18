# frozen_string_literal: true
require 'text2svg'
require 'nokogiri'
require 'net/http'
require 'fileutils'
require 'active_support/core_ext/hash/indifferent_access'
require 'json'
require 'zip/zip'


require_relative "markdown_headlines_to_svg/version"

module MarkdownHeadlinesToSvg
  class Error < StandardError; end

  @TEMPLATE=  {
    github: {
      profile: nil,
      source: 'https://raw.githubusercontent.com/'
    },
    font: {
      text_align: :left,
      bold: true,
      local: false,
      source: {
        local_path: '',
        google_fonts: {
          name: 'Amatic SC',
          variant: 'regular',
          subset: 'latin'
        },
        current: nil,
      }
    },
    view: {
      offset: {
        height: -800,
        widht: 0
      }
    },
    style: {
      color: {
        opacity: 1.0,
        default: '#A5834B',
        palette: []
      },
      stroke: {
        color: 'none',
        width: '10px',
        opacity: 1.0,
        linecap: 'butt'
      }
    }
  }


  def self.get_options()
    return @TEMPLATE
  end


  def self.generate( markdowns, gh_name, options = {} )
    if self.validate( markdowns, gh_name, options, @TEMPLATE )
      obj = self.options_update( options, @TEMPLATE, 'set_options' )
      obj[:github][:profile] = gh_name

      if obj[:font][:source][:user].nil?
        obj[:font][:source][:current] = obj[:font][:source][:default]
      else
        obj[:font][:source][:current] = obj[:font][:source][:user]
      end

      if obj[:font][:local] 
        obj[:font][:source][:current] = obj[:font][:source][:local_path]
      else
        obj[:font][:source][:current] = "./tmp-#{Time.now.getutc.to_i}.ttf"
        google_font_download( 
          obj[:font][:source][:google_fonts][:name], 
          obj[:font][:source][:google_fonts][:variant], 
          obj[:font][:source][:google_fonts][:subset], 
          obj[:font][:source][:current]
        )
      end

      cmds = self.markdowns_read( markdowns, obj )
      root = './'
      cmds.each do | cmd |
        svg = self.svg_generate( cmd[:headline], obj )
        FileUtils.mkdir_p ( File.dirname( cmd[:path] ) )
        File.open( cmd[:path], "w" ) { | f | f.write( svg ) }
      end
    end

    !obj[:font][:local] ? File.delete( obj[:font][:source][:current] ) : ''

    return true
  end


  private


  def self.str_difference( a, b )
    a = a.to_s.downcase.split( '_' ).join( '' )
    b = b.to_s.downcase.split( '_' ).join( '' )
    longer = [ a.size, b.size ].max
    same = a
      .each_char
      .zip( b.each_char )
      .select { | a, b | a == b }
      .size
    ( longer - same ) / a.size.to_f
  end


  def self.google_font_download( font, style, subset, file_name )    
    def self.unzip_file( file, destination, file_name )
      Zip::ZipFile.open( file ) do | zip_file |
       zip_file.each do | f |
         f_path=File.join( destination, file_name )  
         FileUtils.mkdir_p( File.dirname( f_path ) )
         zip_file.extract( f, f_path ) unless File.exist?( f_path )
       end
      end
    end
  

    server = 'https://google-webfonts-helper.herokuapp.com'
    url = "#{server}/api/fonts"
    uri = URI( url )
    response = Net::HTTP.get( uri )
    fonts_all = JSON.parse( response )
  
    fonts_subset = fonts_all.select { | a | a["subsets"].include?( subset ) }
  
    id = fonts_subset
      .map { | a | { name: a["id"], score: self.str_difference( font, a["id"] ) } }
      .min_by { | h | h[:score] }
  
    font = fonts_subset
      .find { | a | a["id"].eql? id[:name] }
  
    variant = font['variants']
      .map { | a | { name: a, score: self.str_difference( style.to_s, a.to_s ) } }
      .min_by { | h | h[:score] }
  
    puts "Font: #{font["id"]} #{variant[:name]} (#{subset})"
    
    url = ''
    url += server
    url += "/api/fonts/#{id[:name]}?download=zip&subsets=#{subset}&formats=ttf&variants=#{variant[:name]}"
  
    uri = URI( url )
    response = Net::HTTP.get( uri )
  
    path_zip = "./tmp-#{Time.now.getutc.to_i}.zip"
    
    File.open( path_zip, "w" ) { | f | f.write( response ) }
    unzip_file( path_zip, File.dirname( path_zip ), file_name )
    
    File.delete( path_zip )
  end


  def self.validate( markdowns, gh_name, vars, template )
    messages = {
      markdowns: [],
      github: [],
      options: [],
      other: []
    }

    begin
      if markdowns.class.to_s.eql? 'Array'
        if markdowns.map { | a | a.start_with?( template[:github][:source] ) }.all?
          if markdowns.map { | a | a.end_with?( '.md' ) }.all?

          else
            messages[:markdowns].push( "Make sure all your .md Files end with .md")
          end
        else
          messages[:markdowns].push( "Make sure all your .md Files start with: #{template[:github][:source]}")
        end
      else
        messages[:markdowns].push( 'Is not Type "Array" or "String".' )
      end

      if gh_name.class.to_s.eql? 'String'
        if !gh_name.eql? ''

        else
          messages[:github].push( "Github Name is required." )
        end
      else
        messages[:github].push( 'Is not Type "String".' )
      end

      if vars.class.to_s == 'Hash'
        messages[:options] = self.options_update( vars, template, 'options_valid?' )
      else
        messages[:options].push( 'Is not Type "Hash".') 
      end

    rescue
      messages[:other].push( "Undefined error occured.")
    end

    valid = messages.keys.map { | key | messages[ key ].length }.sum == 0

    if !valid
      puts 'Following errors occured:'
      messages.keys.each do | key |
        if messages[ key ].length != 0

          puts "  #{key[ 0, 1 ].upcase}#{key[ 1, key.length ]}"
          messages[ key ].each do | m |
            puts "  - #{m}"
          end
        end
      end
    end

    return valid
  end


  def self.options_update( vars, template, mode )
    allow_list =     [
      :font__text_align,
      :font__bold,
      :font__local,
      :font__source__local_path,
      :font__source__google_fonts__name,
      :font__source__google_fonts__variant,
      :font__source__google_fonts__subset,
      :view__offset__height,
      :view__offset__widht,
      :style__color__opacity,
      :style__color__default,
      :style__color__palette,
      :style__stroke__color,
      :style__stroke__width,
      :style__stroke__opacity,
      :style__stroke__linecap
    ]

    messages = []
    _options = Marshal.load( Marshal.dump( template ) )
    
    vars.keys.each do | key |
      if allow_list.include?( key ) 
  
        keys = key.to_s.split( '__' ).map { | a | a.to_sym }
        case( keys.length )
          when 1
            _options[ keys[ 0 ] ] = vars[ key ]
          when 2
            _options[ keys[ 0 ] ][ keys[ 1 ] ] = vars[ key ]
          when 3
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] = vars[ key ]
          when 4
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ] = vars[ key ]
        end
      else
        nearest = allow_list
          .map { | word | { score: self.str_difference( key, word ), word: word } }
          .min_by { | item | item[:score] }

        message = "\"#{key}\" is not a valid key, did you mean \"<--similar-->\"?"
        message = message.gsub( '<--similar-->', nearest[:word].to_s )
        messages.push( message )
      end
    end
    
    result = nil
    case mode
      when 'options_valid?'
        result = messages
      when 'set_options'
        result = _options
    end

    return result
  end


  def self.svg_elements( svg )
    svg = svg[ svg.index( "<path transform" ), svg.length ]
    svg = svg[ 0, svg.rindex( "\n</g>\n</svg>\n" ) ]
    elements = []
    found = true
    while found
      to = '/>'
      element = svg[ 0, svg.index( to ) + to.length ].strip
      elements.push( element )
      svg = svg[ svg.index( to ) + to.length, svg.length ]
      !svg.include?( 'path' ) ? found = false : ''
    end
  
    return elements
  end


  def self.svg_items_decode( str, elements, obj )
    def self.svg_item( char, color, element, obj )
      item = {
        "character": nil,
        "fill": nil,
        "fill-opacity": nil,
        "stroke": nil,
        "stroke-width": nil,
        "stroke-linecap": nil,
        "stroke-opacity": nil,
        "transform": nil,
        "d": nil
      }

      item[:"character"] = char
      item[:"fill"] = color
      item[:"fill-opacity"] = obj[:style][:color][:opacity]
      item[:"stroke"] = obj[:style][:stroke][:color]
      item[:"stroke-width"] = obj[:style][:stroke][:width]
      item[:"stroke-linecap"] = obj[:style][:stroke][:linecap]
      item[:"stroke-opacity"] = obj[:style][:stroke][:opacity]
  
      [ :"transform", :"d" ].each do | key |
        search = key.to_s
        doc = Nokogiri::XML( element )
        item[ key ] = doc.xpath("//*[@#{search}]")[ 0 ].attribute( search ).to_s
      end

      return item
    end
    
    
    characters = str.gsub( ' ', '' )
    items = []
    elements.each.with_index do | element, index |
      if obj[:style][:color][:palette].length <= index
        color = obj[:style][:color][:default]
      else
        color = obj[:style][:color][:palette][ index ]
      end
      
      item = self.svg_item( characters[ index ], color, element, obj )
      items.push( item )
    end
    return items
  end


  def self.svg_header( svg, items, obj )
    element = svg[ 0, svg.index( "<path transform" ) ]
    search = 'viewBox'
    doc = Nokogiri::XML( element )
    values = doc.xpath("//*[@#{search}]")[ 0 ].attribute( search ).to_s
    values_mod = values.split( ' ' ).map { | a | a.to_i }
    values_mod[ 3 ] = values_mod[ 3 ] + obj[:view][:offset][:height]
    from = "viewBox=\"#{values}\""
    to = "viewBox=\"#{values_mod.join(' ')}\""
    element = element.gsub( from, to )
    return element
  end


  def self.svg_create_code( items, svg, obj )
    el = items.map do | item | 
      p = ''
      p += "\t\t<path "
      p += item.map { | c | "#{c[ 0 ]}=\"#{c[ 1 ]}\"" }.join( ' ' ) 
      p += '/>'
    end
  
    el = el.join( "\n" )
  
    code = ''
    code += self.svg_header( svg, items, obj )
    code += el.to_s
    code += "\n</g>\n</svg>"
    return code
  end


  def self.svg_generate( str, obj )
    svg = Text2svg( 
      str, 
      font: obj[:font][:source][:current], 
      text_align: obj[:font][:text_align], 
      bold: obj[:font][:bold]
    ).to_s
  
    elements = self.svg_elements( svg )
    items = self.svg_items_decode( str, elements, obj )
    code = self.svg_create_code( items, svg, obj )
    return code
  end


  def self.markdowns_read( markdowns, obj )
    def self.markdown_read( url, obj )
      messages = []
      cmds = []

        uri = URI( url )
        response = Net::HTTP.get( uri )
        doc = Nokogiri::HTML( response )
        doc.xpath( '//img' ).each do | element |
          begin
            if !element.attribute( 'banner' ).nil?
              validation = "#{obj[:github][:source]}#{obj[:github][:profile]}/"
              cmd = {
                headline: nil,
                src: nil,
                file: nil,
                path: nil
              }
              
              cmd[:src] = element.attribute( 'src' ).value
              cmd[:file] = File.basename( cmd[:src] )

              if cmd[:src].start_with?( validation )
                if cmd[:src].end_with?( '.svg' ) 
                  if url =~ URI::regexp
                    cmd[:headline] = element.attribute( 'banner' ).value
                    
                    tmp = cmd[:src][ cmd[:src].index( validation ) + validation.length, cmd[:src].length ]
                    tmp = tmp
                      .split( '/' )
                      .reject { | a | a.empty? }
                      .drop( 2 )
                      .join( '/' )
                    cmd[:path] = './' + tmp
                    cmds.push( cmd )
                  else
                    messages.push( "#{cmd[:file]}: Invalid URL Structure." )
                  end
                else
                  messages.push( "#{cmd[:file]}: Suffix is not valid. Please use .svg instead." )
                end
              else
                messages.push( "#{cmd[:file]}: URL not start with: \"#{validation}\"" )
              end
            end
          rescue
            messages.push( "#{url}: Can not load or a parsing Error occured." )
          end
        end
      return [ cmds, messages ]
    end
    
    
    errors = {}
    cmds = []
    markdowns.each do | url |
      cmds_tmp, errors_tmp = self.markdown_read( url, obj )
      cmds = cmds.concat( cmds_tmp )
      errors[ url ] = errors_tmp
    end
    
    err = errors.keys.map { | key | errors[ key ].length }.sum
    if err != 0
      str = 'Following Error'
      err > 1 ? str += 's' : ''
      str += ' occured: '
      puts str
      
      errors.keys.each do | key |
        if errors[ key ].length != 0
          puts "  " + key + ':'
          errors[ key ].each do | error |
            puts '  - ' + error
          end
        end
      end
    end
    
    return cmds
  end
end
