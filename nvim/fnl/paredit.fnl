(let [paredit (require :nvim-paredit)]
  paredit.setup
  {:use_default_keys false
   ;  :filetypes [:clojure :fennel]
   ; "remain" | "follow" | "auto" default is "auto"
   :cursor_behaviour :auto
   :indent {:enabled false
            :indentor (. (require :nvim-paredit.indentation.native) :indentor)}
   :keys ["<localleader>@"
          [paredit.unwrap.unwrap_form_under_cursor "Splice sexp"]
          ">)"
          [paredit.api.slurp_forwards "Slurp forwards"]
          ">("
          [paredit.api.barf_backwards "Barf backwards"]
          "<)"
          [paredit.api.barf_forwards "Barf forwards"]
          "<("
          [paredit.api.slurp_backwards "Slurp backwards"]
          :>e
          [paredit.api.drag_element_forwards "Drag element right"]
          :<e
          [paredit.api.drag_element_backwards "Drag element left"]
          :>f
          [paredit.api.drag_form_forwards "Drag form right"]
          :<f
          [paredit.api.drag_form_backwards "Drag form left"]
          :<localleader>o
          [paredit.api.raise_form "Raise form"]
          :<localleader>O
          [paredit.api.raise_element "Raise element"]
          :E
          {:1 paredit.api.move_to_next_element_tail
           :2 "Jump to next element tail"
           :repeatable false
           :mode [:n :x :o :v]}
          :W
          {:1 paredit.api.move_to_next_element_head
           :2 "Jump to next element head"
           :repeatable false
           :mode [:n :x :o :v]}
          :B
          {:1 paredit.api.move_to_prev_element_head
           :2 "Jump to previous element head"
           :repeatable false
           :mode [:n :x :o :v]}
          :gE
          {:1 paredit.api.move_to_prev_element_tail
           :2 "Jump to previous element tail"
           :repeatable false
           :mode [:n :x :o :v]}
          "("
          {:1 paredit.api.move_to_parent_form_start
           :2 "Jump to parent form's head"
           :repeatable false
           :mode [:n :x :v]}
          ")"
          {:1 paredit.api.move_to_parent_form_end
           :2 "Jump to parent form's tail"
           :repeatable false
           :mode [:n :x :v]}
          :af
          {:1 paredit.api.select_around_form
           :2 "Around form"
           :repeatable false
           :mode [:o :v]}
          :if
          {:1 paredit.api.select_in_form
           :2 "In form"
           :repeatable false
           :mode [:o :v]}
          :aF
          {:1 paredit.api.select_around_top_level_form
           :2 "Around top level form"
           :repeatable false
           :mode [:o :v]}
          :iF
          {:1 paredit.api.select_in_top_level_form
           :2 "In top level form"
           :repeatable false
           :mode [:o :v]}
          :ae
          {:1 paredit.api.select_element
           :2 "Around element"
           :repeatable false
           :mode [:o :v]}
          :ie
          {:1 paredit.api.select_element
           :2 :Element
           :repeatable false
           :mode [:o :v]}]})
