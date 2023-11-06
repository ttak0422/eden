((. (require :auto-indent) :setup) {:lightmode true
                                    :indentexpr (fn [lnum]
                                                  (((. require
                                                       :nvim-treesitter.indent) :get_indent) lnum))
                                    :ignore_filetype {}})
