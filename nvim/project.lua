require("project_nvim").setup({
  manual_mode = false,
  detection_methods = { "pattern" },
  patterns = { ".git" },
  scope_chdir = "tab",
})
