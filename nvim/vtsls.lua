-- require `npm install -g @vtsls/language-server`
require("vtsls").config({
  -- wip
  -- handlers = {
  --     source_definition = function(err, locations) end,
  --     file_references = function(err, locations) end,
  --     code_action = function(err, actions) end,
  -- },
  refactor_auto_rename = true,
})
