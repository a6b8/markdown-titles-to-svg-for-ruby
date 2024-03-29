<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/custom/markdown-titles-to-.svg-for-ruby.svg" height="45px" alt="Markdown Titles to .svg for Ruby." name="# Markdown Titles to .SVG For Ruby">
</a>

Headline Generator for ```Github Markdown``` File to generate beautiful ```Google Fonts``` Headlines. 

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/examples.svg" height="45px" alt="Examples" name="examples">
</a>

<br>
<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/20.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Permanent Marker" }
```

<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/21.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Playfair Display" }
```

<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/22.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Roboto Condensed" }
```

<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/23.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Sarina" }
```

<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/24.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Sonsie One" }
```

<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/25.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Trocchi" }
```

<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/26.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "UnifrakturMaguntia" }
```
<a href="#examples">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/markdown-titles-to-svg-for-ruby/examples/27.svg" height="38px">
</a>

```ruby
{ font__google_fonts__h1__name: "Zilla Slab Highlight" }
```

<br>

<a href="#headline">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/table-of-contents.svg" height="45px" alt="Table of Contents" name="table-of-contents">
</a>

1. [Examples](#examples)<br>
2. [Quickstart](#quickstart)<br>
3. [Demo](#demo)<br>
4. [Setup](#setup)<br>
5. [Process](#process)<br>
6. [Functions](#functions)<br>
7. [Options](#options)<br>
8. [Limitations](#limitations)<br>
9. [Contributing](#contributing)<br>
10. [License](#license)<br>
11. [Code of Conduct](#code-of-conduct)<br>
12. [Support my Work](#support-my-work)<br>

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/quickstart.svg" height="45px" alt="Quickstart" name="quickstart">
</a>

**Single Title**
```ruby
require 'markdown_titles_to_svg'

svg = MarkdownTitlesToSvg.single( 
    'headline',
    :h1,
    {}
)
```


**Generate from Github Markdown**
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

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/setup.svg" height="45px" alt="Setup" name="setup">
</a>

Add this line to your application's Gemfile:

```ruby
gem 'markdown_headlines_to_svg'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install markdown_headlines_to_svg

![](https://ruby-gem-downloads-badge.herokuapp.com/markdown_titles_to_svg?type=total&color=lightgray)

<br>

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/demo.svg" height="45px" alt="Demo" name="demo">
</a>

**A. Implementation**
> https://raw.githubusercontent.com/a6b8/a6b8/main/README.md


**B. Execution**
> https://github.com/a6b8/a6b8/blob/main/titles.sh

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/process.svg" height="45px" alt="Process" name="process">
</a>

1. Run Command
```txt
mds = [ PATH_FILE1, PATH_FILE2 ]
markdown_headlines_to_svg.generate(
    mds,
    "github_profile_name",
    options = {}
)
```

2. Prepare (Import) Font
``` txt
           :h1          :default
            |              |
            | mode         | mode
        ----------     ----------
        |        |     |        |
        v        v     v        v
      Local    Google Fonts   Local
```

3. Scrape Titles
``` txt

    MD_FILE_ 1                                                    QUEUE
    ------------------------------------------------------        
    |  img src="../a/c/d/1.svg" alt="# Headline 1" ------|------> [ 0 ] 
    |                                                    |        
    |    MD_FILE_2                                       |        
    |    -----------------------------------------------------   
    |    |  img src="../b/c/d/1.svg" alt="# Headline 2" -----|->  [ 1 ] 
    |----|  ...                                              |   
         |  img src="../c/d/e/2.svg" alt="Title 1" ----------|->  [ 2 ] 
         |  ...                                              |   

    [ 0 ] { text: 'Headline 1', type: :h1, output: '../a/c/d/1.svg' }
    [ 1 ] { text: 'Headline 2', type: :h1, output: '../b/c/d/1.svg' }
    [ 2 ] { text: 'Title 1', type: :default, output: '../c/d/e/2.svg' }
```

4. Add Style and Font Options

``` txt                       
                                 default
                                 + user options
{                                   |
    type: :h1, ---------------------|------------------                        
    text: 'Headline 1',             |                 |
    output: '../a/c/d/1.svg',       V                 V
    style: <-------------------- options[ :style ][ :h1 ]
    font: <---------------------- options[ :font ][ :h1 ]
},
{ ...

```

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/functions.svg" height="45px" alt="Functions" name="functions">
</a>

### .get_options()
Output all Parameter
```ruby
MarkdownTitlesToSvg.get_options()

# => { github: { profile: nil, ...
```

### .generate( [], '', {} )
Generate and store of Titles in all Files
```ruby
MarkdownTitlesToSvg.generate(
    markdowns,
    'a6b8',
    {}
)
```

| **Type** | **Required** | **Description** | **Example** | **Description** |
|------:|:------|:------|:------|:------| 
| **markdowns** | ```Array (of String)``` | Yes | ```[ '/markdown-titles-to-svg/main/README.md' ]``` | Define List of Markup |
| **github user name** | ```String``` | Yes | ```'a6b8'``` | Set Github User Name |
| **options** | ```Hash``` | No | ```'a6b8'``` | Change default options, see "options" for more Information. |

### .single( [], '', {} )
Generate a single Title and outputs a svg string.
```ruby
svg = MarkdownTitlesToSvg.single( 
    'headline',
    :h1,
    {}
)

# => <svg ...
```

| **Type** | **Required** | **Description** | **Example** | **Description** |
|------:|:------|:------|:------|:------| 
| **headline** | ```String``` | Yes | ```'headline'``` | Set Text of Headline/Title |
| **style** | ```Symbol``` | Yes | ```:h1``` | Set type of style, choose between :h1 and :default |
| **options** | ```Hash``` | No | ```{}``` | Change default options, see "options" for more Information. |

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/options.svg" height="45px" alt="Options" name="options">
</a>

### Github
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| A.1. | Source |:github__source | `"https://raw.githubusercontent.com/"` | String | |


### Font
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.1. | Text_align |:font__text_align | `left` | Symbol | Set aligment of text |
| B.2. | Bold |:font__bold | `false` | Boolean | Set format of font. If you use Google Fonts try "variant first" |
| B.3. | Mode H1 |:font__mode__h1 | `:google_fonts` | Symbol | Set mode for Headlines. Choose between ```:local``` and ```:google_fonts``` |
| B.4. | Mode Default |:font__mode__default | `:google_fonts` | Symbol | Set mode for Titles. Choose between ```:local``` and ```:google_font``` |


#### Import from Local
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.5. | H1 |:font__local__h1 | `"/Library/Fonts/Microsoft/Corbel Bold.ttf"` | String | Set local font for Headline if necessary |
| B.6. | Default |:font__local__default | `"/Library/Fonts/Microsoft/Consolas.ttf"` | String | String | Set local font for Titles if necessary |


#### Import from "Google Fonts"
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.7. | H1 Name |:font__google_fonts__h1__name | `"Oswald"` | String | Set Google Fonts font name for Headline |
| B.8. | H1 Variant |:font__google_fonts__h1__variant | `"regular"` | String | Set Google Fonts variant type for headlines |
| B.9. | H1 Subset |:font__google_fonts__h1__subset | `"latin"` | String | Set Google Fonts subset type for headlines |
| B.10. | Default Name |:font__google_fonts__default__name | `"Amatic SC"` | String | Set Google Fonts font name for Titles |
| B.11. | Default Variant |:font__google_fonts__default__variant | `"regular"` | String | Set Google Fonts variant type for titles |
| B.12. | Default Subset |:font__google_fonts__default__subset | `"latin"` | String | Set Google Fonts subset type for titles |

Please use https://google-webfonts-helper.herokuapp.com/fonts to find your favorite Font.

### View
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| C.1. | Offset Height |:view__offset__height | `0` | Integer | Experimental: Set change View Box height |
| C.2. | Offset Widht |:view__offset__widht | `0` | Integer | Experimental: Set change View Box width |

### Style

#### Headlines
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Color Opacity |:style__h1__color__opacity | `1.0` | Float | Change Headline color opacity |
| D.2. | Color Default |:style__h1__color__default | `"#A5834B"` | String | Change Headline fill color |
| D.3. | Color Palette |:style__h1__color__palette | `[]` | Array | Experimental: Set for each character in headline an other color |
| D.4. | Stroke Color |:style__h1__stroke__color | `"none"` | String | Change headline fill color of stroke |
| D.5. | Stroke Width |:style__h1__stroke__width | `"0"` | String | Change headline stroke width |
| D.6. | Stroke Opacity |:style__h1__stroke__opacity | `1.0` | Float | Change headline stroke opacity |
| D.7. | Stroke Linecap |:style__h1__stroke__linecap | `"butt"` | String | Change headline stroke width |

#### Default
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.8. | Color Opacity |:style__default__color__opacity | `1.0` | Float | Change Title color opacity |
| D.9. | Color Default |:style__default__color__default | `"#A5834B"` | String | Change Title fill color |
| D.10. | Color Palette |:style__default__color__palette | `[]` | Array | Experimental: Set for each character in titles an other color |
| D.11. | Stroke Color |:style__default__stroke__color | `"none"` | String | Change title fill color of stroke |
| D.12. | Stroke Width |:style__default__stroke__width | `"0"` | String | Change title stroke width |
| D.13. | Stroke Opacity |:style__default__stroke__opacity | `1.0` | Float | Change title stroke opacity |
| D.14. | Stroke Linecap |:style__default__stroke__linecap | `"butt"` | String | Change title stroke width |

You can find more Information about ```svg``` format here: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path


### Other
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| E.1. | Silent | :silent | `false` | Boolean | Controll console output. |

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/contributing.svg" height="45px" alt="Contributing" name="contributing">
</a>

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/markdown-titles-to-svg-for-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/statosio/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/limitations.svg" height="45px" alt="Limitations" name="limitations">
</a>

- Font Types are limited to '.ttf' and '.otf'. 
- Read only Markdown Files from Github.

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/credits.svg" height="45px" name="credits" alt="Credits">
</a>

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/license.svg" height="45px" alt="License" name="license">
</a>

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/code-of-conduct.svg" height="45px" alt="Code of Conduct" name="code-of-conduct">
</a>
    
Everyone interacting in the Statosio project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/markdown-titles-to-svg-for-ruby/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img href="#table-of-contents" src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/star-us.svg" height="45px" name="star-us" alt="Star us">
</a>

Please ⭐️ star this Project, every ⭐️ star makes us very happy!