require '../lib/markdown_titles_to_svg'


tests = [
    { 
        font__google_fonts__h1__name:'Alex Brush'
    },
    { 
        font__google_fonts__h1__name: 'Advent Pro',
        style__h1__color__default: 'none',
        style__h1__stroke__color: '#A5834B',
        style__h1__stroke__width: 20

    },
    { 
        font__google_fonts__h1__name: 'Archivo Narrow' ,
        style__h1__color__default: 'none',
        style__h1__stroke__color: '#A5834B',
        style__h1__stroke__width: 20
    },
    { 
        font__google_fonts__h1__name: 'Artifika' ,
        style__h1__color__default: 'none',
        style__h1__stroke__color: '#A5834B',
        style__h1__stroke__width: 20
    },
    { 
        font__google_fonts__h1__name: 'Astloch' ,
        style__h1__color__default: 'none',
        style__h1__stroke__color: '#A5834B',
        style__h1__stroke__width: 20
    },
    { 
        font__google_fonts__h1__name: 'Atma' ,
        style__h1__color__default: 'none',
        style__h1__stroke__color: '#A5834B',
        style__h1__stroke__width: 20
    },
    { 
        font__google_fonts__h1__name: 'Bangers'
    },
    { 
        font__google_fonts__h1__name: 'Bebas Neue'
    },
    { 
        font__google_fonts__h1__name: 'Bungee Hairline'
    },
    { 
        font__google_fonts__h1__name: 'Fjallo One'
    },
    { 
        font__google_fonts__h1__name: 'Hammersmith One',
        style__h1__color__default: 'none',
        style__h1__stroke__color: '#A5834B',
        style__h1__stroke__width: 20
    },
    { 
        font__google_fonts__h1__name: 'Happy Monkey'
    },
    { 
        font__google_fonts__h1__name: 'IM Fell French Canon SC' 
    },
    { 
        font__google_fonts__h1__name: 'JetBrains Mono',
        style__h1__color__palette: [ '#2A2B2A', '#5E4955', '#996888', '#C99DA3', '#C99DA3', '#996888', '#5E4955', '#2A2B2A' ] 
    },
    { 
        font__google_fonts__h1__name: 'Josefin Sans',
        style__h1__color__palette: [ '#2A2B2A', '#5E4955', '#996888', '#C99DA3', '#C99DA3', '#996888', '#5E4955', '#2A2B2A' ] 
    },
    { 
        font__google_fonts__h1__name: 'Kaushan Script' 
    },
    { 
        font__google_fonts__h1__name: 'Libre Barcode 128 Text',
    },
    { 
        font__google_fonts__h1__name: 'Luckiest Guy' 
    },
    { 
        font__google_fonts__h1__name: 'Marcellus' 
    },
    { 
        font__google_fonts__h1__name: 'Orelega One' 
    },
    { 
        font__google_fonts__h1__name: 'Permanent Marker' 
    },
    { 
        font__google_fonts__h1__name: 'Playfair Display' 
    },
    { 
        font__google_fonts__h1__name: 'Roboto Condensed' 
    },
    { 
        font__google_fonts__h1__name: 'Sarina' 
    },
    { 
        font__google_fonts__h1__name: 'Sonsie One' 
    },
    { 
        font__google_fonts__h1__name: 'Trocchi' 
    },
    { 
        font__google_fonts__h1__name: 'UnifrakturMaguntia' 
    },
    { 
        font__google_fonts__h1__name: 'Zilla Slab Highlight'
    }
]

#=begin

markdown = ''
for index in 0..tests.length-1
    svg = MarkdownTitlesToSvg.single( 
        'headline',
        :h1,
        tests[ index ]
    )


    path = "./example/#{index}.svg"
    FileUtils.mkdir_p ( File.dirname( path ) )
    File.open( path, "w" ) { | f | f.write( svg ) }

    str = '<'
end

#=end

source = 'https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/examples/'

l = ''
tests.each.with_index do | test, index | 
    strs = ''
    strs += "<img src=\"#{source}#{index}.svg\" height=\"45px\">\n\n"

    strs += "```ruby\n\t"
    if test.keys.length == 1
        s = test[ test.keys[ 0 ] ]
        s.class.to_s.eql? 'String' ? s = "\"#{s}\"" : ''
        strs += "{ #{test.keys[ 0 ]}: #{s} }\n"
    else
        strs += "```ruby\n\t{\n"
        test.keys.each.with_index do | key, index | 
            s = test[key]
            s.class.to_s.eql?( 'String' ) ? s = "\"#{s}\"" : ''
            strs += "\t\t#{key}: #{s}"
            test.keys.length-1 != index ? strs += ',' : ''
            strs += "\n"
        end
        strs += "\t}\n"
    end
    strs += "```\n\n"    
    l += strs
end

File.open( 'examples.txt', "w" ) { | f | f.write( l ) }
