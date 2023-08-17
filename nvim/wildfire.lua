require("wildfire").setup({
  surrounds = {
    { "(", ")" },
    { "{", "}" },
    { "<", ">" },
    { "[", "]" },
  },
  keymaps = {
    init_selection = "<CR>",
    node_incremental = "<CR>",
    node_decremental = "<BS>",
  },
})
