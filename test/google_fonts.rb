require 'net/http'
require 'zip/zip'
require 'json'


def google_font_download( font, style, subset, file_name )
  def str_difference( a, b )
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
  
  
  def unzip_file( file, destination, file_name )
    Zip::ZipFile.open( file ) do |zip_file|
     zip_file.each do | f |
       f_path=File.join( destination, file_name )  
       FileUtils.mkdir_p( File.dirname( f_path ) )
       zip_file.extract( f, f_path ) unless File.exist?( f_path )
     end
    end
  end

  
  url = 'https://google-webfonts-helper.herokuapp.com/api/fonts'
  uri = URI( url )
  response = Net::HTTP.get( uri )
  fonts_all = JSON.parse( response )

  fonts_subset = fonts_all.select { | a | a["subsets"].include? subset }

  id = fonts_subset
    .map { | a | { name: a["id"], score: str_difference( font, a["id"] ) } }
    .min_by { | h | h[:score] }

  font = fonts_subset
    .find { | a | a["id"].eql? id[:name] }

  variant = font['variants']
    .map { | a | { name: a, score: str_difference( style.to_s, a.to_s ) } }
    .min_by { | h | h[:score] }

  puts "Font: #{font["id"]} #{variant[:name]} (#{subset})"
  
  url = ''
  url += 'https://google-webfonts-helper.herokuapp.com'
  url += "/api/fonts/#{id[:name]}?download=zip&subsets=latin&formats=ttf&variants=#{variant[:name]}"

  uri = URI( url )
  response = Net::HTTP.get( uri )

  path_zip = "./tmp-#{Time.now.getutc.to_i}.zip"
  
  File.open( path_zip, "w" ) { | f | f.write( response ) }
  unzip_file( path_zip, File.dirname( path_zip ), file_name )
  
  File.delete( path_zip )
end


google_font_download( 'Amatic SC', '700', 'latin', 'amatic.ttf' )