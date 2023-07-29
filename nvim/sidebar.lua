require("sidebar-nvim").setup({
  disable_default_keybindings = 1,
  bindings = nil,
  open = true,
  side = "left",
  initial_width = 35,
  hide_statusline = false,
  update_interval = 1000,
  sections = { "datetime", "git", "diagnostics" },
  section_separator = { "", "-----", "" },
  section_title_separator = { "" },
  containers = {
    attach_shell = "/bin/sh",
    show_all = true,
    interval = 5000,
  },
  datetime = {
    icon = "",
    format = "%a %b %d, %H:%M",
    clocks = { { name = "local" } },
  },
  git = {
    icon = "",
  },
  todos = { ignored_paths = { "~" } },
})
