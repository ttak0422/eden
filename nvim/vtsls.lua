-- require `npm install -g @vtsls/language-server`

local node_root_dir = require("lspconfig").util.root_pattern("package.json")
local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

if is_node_repo then
  require("vtsls").config({
    -- wip
    -- handlers = {
    --     source_definition = function(err, locations) end,
    --     file_references = function(err, locations) end,
    --     code_action = function(err, actions) end,
    -- },
    refactor_auto_rename = true,
  })
end
