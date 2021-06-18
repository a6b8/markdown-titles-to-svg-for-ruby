def get_allow_list( params )
        
    lists[:allow] = []
    lists[:block] = []

    params.keys.each do | lvl1 |
        if params[ lvl1 ].class.to_s.eql? 'Hash'
            params[ lvl1 ].keys.each do | lvl2 |
                if params[ lvl1 ][ lvl2 ].class.to_s.eql? 'Hash'
                    params[ lvl1 ][ lvl2 ].keys.each do | lvl3 |
                        if params[ lvl1 ][ lvl2 ][ lvl3 ].class.to_s.eql? 'Hash'
                            params[ lvl1 ][ lvl2 ][ lvl3 ].keys.each do | lvl4 |
                                if params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].class.to_s.eql? 'Hash'
                                    puts 'HERE'
                                else
                                    str = ( lvl1.to_s + '__' + lvl2.to_s + '__' + lvl3.to_s + '__' + lvl4.to_s ).to_sym
                                    if !params[ lvl1 ][ lvl2 ][ lvl3 ][ lvl4 ].nil?
                                        lists[:allow].push( str )
                                    else
                                        lists[:block].push( str )
                                    end
                                end
                            end
                        else
                            str = ( lvl1.to_s + '__' + lvl2.to_s + '__' + lvl3.to_s ).to_sym
                            if !params[ lvl1 ][ lvl2 ][ lvl3 ].nil?
                                lists[:allow].push( str )
                            else
                                lists[:block].push( str )
                            end
                        end
                    end
                else
                    str = ( lvl1.to_s + '__' + lvl2.to_s ).to_sym
                    if !params[ lvl1 ][ lvl2  ].nil? 
                        lists[:allow].push( str )
                    else
                        lists[:block].push( str )
                    end
                end
            end
        else
            str = lvl1
            if !params[ lvl1 ].nil?
                lists[:allow].push( str )
            else
                lists[:block].push( str )
            end
        end
    end
    return lists
end


test = {
    github: {
        profile: nil,
        source: 'https://raw.githubusercontent.com/'
        },
    font: {
        text_align: :left,
        bold: false,
        mode: {
            h1: :local,
            default: :google_fonts
        },
        local: {
            h1: nil,
            default: nil
        },
        google_fonts: {
            h1: {
                name: 'Oswald',
                variant: 'regular',
                subset: 'latin'         
            },
            default: {
                name: 'Amatic SC',
                variant: 'regular',
                subset: 'latin'              
            } 
        },
        current: {
            h1: nil,
            default: nil
        }
    },
    view: {
        offset: {
            height: 0,
            widht: 0
        }
    },
    style: {
        h1: {
            color: {
                opacity: 1.0,
                default: '#A5834B',
                palette: []
            },
            stroke: {
                color: 'none',
                width: '0px',
                opacity: 1.0,
                linecap: 'butt'
            }
        },
        default: {
            color: {
                opacity: 1.0,
                default: '#A5834B',
                palette: []
            },
            stroke: {
                color: 'none',
                width: '0px',
                opacity: 1.0,
                linecap: 'butt'
            }
        }
    }
}

get_allow_list( test )