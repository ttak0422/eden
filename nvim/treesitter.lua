local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter_parser"
vim.opt.runtimepath:append(parser_install_dir)
require("nvim-treesitter.configs").setup({
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  parser_install_dir = parser_install_dir,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  yati = {
    enable = true,
    default_lazy = true,
    default_fallback = "auto",
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = true,
    query = "rainbow-parens",
    strategy = require("ts-rainbow").strategy.global,
    hlgroups = {
      -- 'TSRainbowRed', 原色寄りすぎる...
      "TSRainbowYellow",
      "TSRainbowBlue",
      "TSRainbowOrange",
      "TSRainbowGreen",
      "TSRainbowViolet",
      "TSRainbowCyan",
    },
  },
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "outer part of function" },
        ["if"] = { query = "@function.inner", desc = "inner part of function" },
        ["ac"] = { query = "@class.outer", desc = "outer part of class" },
        ["ic"] = { query = "@class.inner", desc = "inner partof class" },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "next function (start)" },
        ["]z"] = { query = "@fold", desc = "next fold (start)" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "next function (end)" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "prev function (start)" },
        ["[z"] = { query = "@fold", desc = "prev fold (start)" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "prev function (end)" },
      },
    },
  },
})
