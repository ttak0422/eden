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
