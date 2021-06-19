<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/Headline.svg" height="55px" alt="# Markdown Headlines to .svg for Ruby">

Headline Generator for ```Github Markdown``` File to generate beautiful ```Google Fonts``` Headlines. 
<br>
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/examples.svg" height="55px" alt="Examples">
<br>
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/quickstart.svg" height="55px" alt="Quickstart">

```ruby
require 'markdown_titles_to_svg'

markdowns = [
    'https://raw.githubusercontent.com/a6b8/a6b8/main/templates/readme.md'
]

MarkdownTitlesToSvg.generate( 
    markdowns,
    'a6b8',
    {}
)
```
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/installation.svg" height="55px" alt="Installation">

Add this line to your application's Gemfile:

```ruby
gem 'markdown_headlines_to_svg'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install markdown_headlines_to_svg
<br>
<br>

## Process

1. Define Markdowns
```ruby
    mds = [ FILE1, FILE2 ]
    markdown_headlines_to_svg.generate(
        mds,
        github_profile,
        {}
    )

```

2. Scrape Titles
```ruby

    FILE1                                                         QUEUE
    ------------------------------------------------------        
    |  <img src="../a/c/d/1.svg" alt="# Headline 1"> ----|------> [ 0 ] 
    |                                                    |        
    |    FILE2                                           |        
    |    -----------------------------------------------------   
    |    |  <img src="../b/c/d/1.svg" alt="# Headline 2"> ---|->  [ 1 ] 
    |    |  ...                                              |   
    |    |  <img src="../c/d/e/2.svg" alt="Title 1"> --------|->  [ 2 ] 
    |    |  ...                                              |   

    [ 0 ] { text: 'Headline 1', type: :h1, path: '../a/c/d/1.svg' }
    [ 1 ] { text: 'Headline 2', type: :h1, path: '../b/c/d/1.svg' }
    [ 2 ] { text: 'Title 1', type: :default, path: '../c/d/e/2.svg' }
```

3. Add Style and Font Options

``` ruby                         
                                 default
                                 + user options
{                                   |
    type: :h1, ---------------------|------------------                        
    text: 'Headline 1',             |                 |
    path: '../a/c/d/1.svg',         V                 V
    style: <-------------------- options[ :style ][ :h1 ]
    font: <---------------------- options[ :font ][ :h1 ]
},
{ ...

```


<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/functions.svg" height="55px" alt="Functions">

Test
<br>
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/options.svg" height="55px" alt="Options">

### Github
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| A.1. | Source |:github__source | `"https://raw.githubusercontent.com/"` | String | |


### Font
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.1. | Text_align |:font__text_align | `left` | Symbol | |
| B.2. | Bold |:font__bold | `false` | Boolean | |
| B.3. | Mode H1 |:font__mode__h1 | `google_fonts` | Symbol | |
| B.4. | Mode Default |:font__mode__default | `google_fonts` | Symbol | |


#### Import from Local
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.5. | H1 |:font__local__h1 | `"/Library/Fonts/Microsoft/Corbel Bold.ttf"` | String | |
| B.6. | Default |:font__local__default | `"/Library/Fonts/Microsoft/Consolas.ttf"` | String | |


#### Import from "Google Fonts"
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.7. | H1 Name |:font__google_fonts__h1__name | `"Oswald"` | String | |
| B.8. | H1 Variant |:font__google_fonts__h1__variant | `"regular"` | String | |
| B.9. | H1 Subset |:font__google_fonts__h1__subset | `"latin"` | String | |
| B.10. | Default Name |:font__google_fonts__default__name | `"Amatic SC"` | String | |
| B.11. | Default Variant |:font__google_fonts__default__variant | `"regular"` | String | |
| B.12. | Default Subset |:font__google_fonts__default__subset | `"latin"` | String | |

Please use https://google-webfonts-helper.herokuapp.com/fonts to find your favorite Font.

### View
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| C.1. | Offset Height |:view__offset__height | `0` | Integer | |
| C.2. | Offset Widht |:view__offset__widht | `0` | Integer | |

### Style

#### Headlines
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Color Opacity |:style__h1__color__opacity | `1.0` | Float | |
| D.2. | Color Default |:style__h1__color__default | `"#A5834B"` | String | |
| D.3. | Color Palette |:style__h1__color__palette | `[]` | Array | |
| D.4. | Stroke Color |:style__h1__stroke__color | `"none"` | String | |
| D.5. | Stroke Width |:style__h1__stroke__width | `"0"` | String | |
| D.6. | Stroke Opacity |:style__h1__stroke__opacity | `1.0` | Float | |
| D.7. | Stroke Linecap |:style__h1__stroke__linecap | `"butt"` | String | |

#### Default
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.8. | Color Opacity |:style__default__color__opacity | `1.0` | Float | |
| D.9. | Color Default |:style__default__color__default | `"#A5834B"` | String | |
| D.10. | Color Palette |:style__default__color__palette | `[]` | Array | |
| D.11. | Stroke Color |:style__default__stroke__color | `"none"` | String | |
| D.12. | Stroke Width |:style__default__stroke__width | `"0"` | String | |
| D.13. | Stroke Opacity |:style__default__stroke__opacity | `1.0` | Float | |
| D.14. | Stroke Linecap |:style__default__stroke__linecap | `"butt"` | String | |


### Other
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| E.1. | Silent | :silent | `false` | Boolean | |

<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/limitations.svg" height="55px" alt="Limitations">

- Font Types are limited to '.ttf' and '.otf'. 
- Read only Markdown Files from Github.
<br>
<br>

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/contributing.svg" height="55px" alt="Contributing">

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/statosio-for-wordpress. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/statosio/blob/master/CODE_OF_CONDUCT.md).
<br>
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/license.svg" height="55px" alt="License">

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
<br>
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/code-of-conduct.svg" height="55px" alt="Code of Conduct">
    
Everyone interacting in the Statosio project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/markdown-titles-to-svg-for-ruby/blob/master/CODE_OF_CONDUCT.md).
<br>
<br>
<br>
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/markdown-titles-to-svg-for-ruby/readme/headlines/support-my-work.svg" height="55px" alt="Support my Work">
    
Donate by [https://www.paypal.com](https://www.paypal.com/donate?hosted_button_id=XKYLQ9FBGC4RG)