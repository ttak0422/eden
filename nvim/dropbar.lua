require("dropbar").setup({
  general = {
    update_interval = 500,
    update_events = {
      win = {
        "CursorMoved",
        "CursorMovedI",
        "WinEnter",
        "WinResized",
      },
      buf = {
        "BufModifiedSet",
        "FileChangedShellPost",
        "TextChanged",
        "TextChangedI",
      },
      global = {
        "DirChanged",
        "VimResized",
      },
    },
  },
  icons = {
    enable = true,
    kinds = {
      use_devicons = true,
      symbols = {
        Array = "󰅪 ",
        Boolean = " ",
        BreakStatement = "󰙧 ",
        Call = "󰃷 ",
        CaseStatement = "󱃙 ",
        Class = " ",
        Color = "󰏘 ",
        Constant = "󰏿 ",
        Constructor = " ",
        ContinueStatement = "→ ",
        Copilot = " ",
        Declaration = "󰙠 ",
        Delete = "󰩺 ",
        DoStatement = "󰑖 ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "󰈔 ",
        Folder = "󰉋 ",
        ForStatement = "󰑖 ",
        Function = "󰊕 ",
        Identifier = "󰀫 ",
        IfStatement = "󰇉 ",
        Interface = " ",
        Keyword = "󰌋 ",
        List = "󰅪 ",
        Log = "󰦪 ",
        Lsp = " ",
        Macro = "󰁌 ",
        MarkdownH1 = "󰉫 ",
        MarkdownH2 = "󰉬 ",
        MarkdownH3 = "󰉭 ",
        MarkdownH4 = "󰉮 ",
        MarkdownH5 = "󰉯 ",
        MarkdownH6 = "󰉰 ",
        Method = "󰆧 ",
        Module = "󰏗 ",
        Namespace = "󰅩 ",
        Null = "󰢤 ",
        Number = "󰎠 ",
        Object = "󰅩 ",
        Operator = "󰆕 ",
        Package = "󰆦 ",
        Property = " ",
        Reference = "󰦾 ",
        Regex = " ",
        Repeat = "󰑖 ",
        Scope = "󰅩 ",
        Snippet = "󰩫 ",
        Specifier = "󰦪 ",
        Statement = "󰅩 ",
        String = "󰉾 ",
        Struct = " ",
        SwitchStatement = "󰺟 ",
        Text = " ",
        Type = " ",
        TypeParameter = "󰆩 ",
        Unit = " ",
        Value = "󰎠 ",
        Variable = "󰀫 ",
        WhileStatement = "󰑖 ",
      },
    },
    ui = {
      bar = {
        separator = "  ",
        extends = "…",
      },
      menu = {
        separator = " ",
        indicator = "  ",
      },
    },
  },
  bar = {
    sources = function(buf, _)
      local sources = require("dropbar.sources")
      local utils = require("dropbar.utils")
      if vim.bo[buf].ft == "markdown" then
        return {
          sources.path,
          utils.source.fallback({
            sources.treesitter,
            sources.markdown,
            -- sources.lsp,
          }),
        }
      end
      return {
        sources.path,
        utils.source.fallback({
          -- sources.lsp,
          sources.treesitter,
        }),
      }
    end,
    padding = {
      left = 0,
      right = 0,
    },
    pick = {
      pivots = "abcdefghijklmnopqrstuvwxyz",
    },
    truncate = true,
  },
  menu = {
    preview = true,
    quick_navigation = true,
    entry = {
      padding = {
        left = 0,
        right = 0,
      },
    },
  },
  sources = {
    lsp = {
      request = {
        ttl_init = 100,
        interval = 1000,
      },
    },
    markdown = {
      parse = {
        look_ahead = 200,
      },
    },
  },
})
