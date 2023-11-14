(local history-ignore (require :history-ignore))

(history-ignore.setup {:ignore_words [:^buf$
                                      :^history$
                                      :^h$
                                      :^q$
                                      :^qa$
                                      :^w$
                                      :^wq$
                                      :^wa$
                                      :^wqa$
                                      :^q!$
                                      :^qa!$
                                      :^w!$
                                      :^wq!$
                                      :^wa!$
                                      :^wqa!$]})
