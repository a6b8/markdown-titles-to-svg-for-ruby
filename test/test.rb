require '../lib/markdown_headlines_to_svg'

markdowns = [
    'https://raw.githubusercontent.com/a6b8/a6b8/main/README.md',
    'https://raw.githubusercontent.com/a6b8/ascii-to-svg-generator-for-ruby/main/README.md'
]

MarkdownHeadlinesToSvg.generate( 
    markdowns,
    'a6b8',
    {}
)