local node_root_dir = require("lspconfig").util.root_pattern("package.json")
local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

if is_node_repo then
  require("typescript-tools").setup({
    on_attach = dofile(args.on_attach_path),
    settings = {
      separate_diagnostic_server = true,
      publish_diagnostic_on = "insert_leave",
      tsserver_plugins = {},
      tsserver_format_options = {},
      tsserver_file_preferences = {},
    },
  })
  vim.cmd([[LspStart]])
end
