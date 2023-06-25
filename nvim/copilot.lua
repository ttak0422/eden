require("copilot").setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<cr>",
      refresh = "r",
      open = "<M-o>",
    },
    layout = {
      position = "bottom",
      ratio = 0.3,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 150,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<M-e>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
})
