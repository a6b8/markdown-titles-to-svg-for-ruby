
require '../lib/markdown_titles_to_svg'

svg = MarkdownTitlesToSvg.single( 
    'A',
    :h1,
    {
        font__mode__h1: :local,
        font__local__h1: 'test.otf'
    }
)

path = 'test.svg'
File.open( path, "w" ) { | f | f.write( svg ) }
