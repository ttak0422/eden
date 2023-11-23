-- [nfnl] Compiled from nvim/fnl/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local paredit = require("nvim-paredit")
do local _ = paredit.setup end
return {cursor_behaviour = "auto", indent = {indentor = (require("nvim-paredit.indentation.native")).indentor, enabled = false}, keys = {"<localleader>@", {paredit.unwrap.unwrap_form_under_cursor, "Splice sexp"}, ">)", {paredit.api.slurp_forwards, "Slurp forwards"}, ">(", {paredit.api.barf_backwards, "Barf backwards"}, "<)", {paredit.api.barf_forwards, "Barf forwards"}, "<(", {paredit.api.slurp_backwards, "Slurp backwards"}, ">e", {paredit.api.drag_element_forwards, "Drag element right"}, "<e", {paredit.api.drag_element_backwards, "Drag element left"}, ">f", {paredit.api.drag_form_forwards, "Drag form right"}, "<f", {paredit.api.drag_form_backwards, "Drag form left"}, "<localleader>o", {paredit.api.raise_form, "Raise form"}, "<localleader>O", {paredit.api.raise_element, "Raise element"}, "E", {["1"] = paredit.api.move_to_next_element_tail, ["2"] = "Jump to next element tail", mode = {"n", "x", "o", "v"}, repeatable = false}, "W", {["1"] = paredit.api.move_to_next_element_head, ["2"] = "Jump to next element head", mode = {"n", "x", "o", "v"}, repeatable = false}, "B", {["1"] = paredit.api.move_to_prev_element_head, ["2"] = "Jump to previous element head", mode = {"n", "x", "o", "v"}, repeatable = false}, "gE", {["1"] = paredit.api.move_to_prev_element_tail, ["2"] = "Jump to previous element tail", mode = {"n", "x", "o", "v"}, repeatable = false}, "(", {["1"] = paredit.api.move_to_parent_form_start, ["2"] = "Jump to parent form's head", mode = {"n", "x", "v"}, repeatable = false}, ")", {["1"] = paredit.api.move_to_parent_form_end, ["2"] = "Jump to parent form's tail", mode = {"n", "x", "v"}, repeatable = false}, "af", {["1"] = paredit.api.select_around_form, ["2"] = "Around form", mode = {"o", "v"}, repeatable = false}, "if", {["1"] = paredit.api.select_in_form, ["2"] = "In form", mode = {"o", "v"}, repeatable = false}, "aF", {["1"] = paredit.api.select_around_top_level_form, ["2"] = "Around top level form", mode = {"o", "v"}, repeatable = false}, "iF", {["1"] = paredit.api.select_in_top_level_form, ["2"] = "In top level form", mode = {"o", "v"}, repeatable = false}, "ae", {["1"] = paredit.api.select_element, ["2"] = "Around element", mode = {"o", "v"}, repeatable = false}, "ie", {["1"] = paredit.api.select_element, ["2"] = "Element", mode = {"o", "v"}, repeatable = false}}, use_default_keys = false}