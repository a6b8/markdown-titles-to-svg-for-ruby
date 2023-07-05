require '../lib/markdown_titles_to_svg.rb'

svg = MarkdownTitlesToSvg.single( 
    'headline',
    :h1,
    {}
)

# File.open( 'headline.svg', 'w' ) { | f | f.write( svg ) }