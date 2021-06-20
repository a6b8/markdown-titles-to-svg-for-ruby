require '../lib/markdown_titles_to_svg'

markdowns = [
    'https://raw.githubusercontent.com/a6b8/statosio-for-ruby/main/README.md',
    'https://raw.githubusercontent.com/a6b8/a6b8/main/README.md',
    #'https://raw.githubusercontent.com/a6b8/ascii-to-svg-generator-for-ruby/main/README.md'
]

MarkdownTitlesToSvg.generate( 
    markdowns,
    'a6b8',
    {
        #style__color__default: '#EA8872'
        #font__source__google_fonts__name: 'Alfa Slab One'
    }
)