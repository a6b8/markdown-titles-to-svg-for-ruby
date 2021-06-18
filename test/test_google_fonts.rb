require '../lib/markdown_titles_to_svg'

markdowns = [
    'https://raw.githubusercontent.com/a6b8/a6b8/main/README.md',
    'https://raw.githubusercontent.com/a6b8/ascii-to-svg-generator-for-ruby/main/README.md'
]

MarkdownTitlesToSvg.generate( 
    markdowns,
    'a6b8',
    {
        font__source__google_fonts__name: 'Press Start 2P',
        font__source__google_fonts__variant: 'regular'
    }
)