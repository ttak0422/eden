require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    opts = {
      zindex = 95,
      -- relative = "cursor",
      -- position = { row = 0, col = 0 },
    },
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim", title = "" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", title = "" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", title = "" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash", title = "" },
      lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua", title = "" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "", title = "" },
      input = {},
    },
  },
  popupmenu = {
    enabled = true,
    backend = "nui",
    kind_icons = {},
  },
  redirect = {
    view = "popup",
    filter = { event = "msg_show" },
  },
  commands = {
    history = {
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {
        any = {
          { event = "notify" },
          { error = true },
          { warning = true },
          { event = "msg_show", kind = { "" } },
          { event = "lsp", kind = "message" },
        },
      },
    },
    last = {
      view = "popup",
      opts = { enter = true, format = "details" },
      filter = {
        any = {
          { event = "notify" },
          { error = true },
          { warning = true },
          { event = "msg_show", kind = { "" } },
          { event = "lsp", kind = "message" },
        },
      },
      filter_opts = { count = 1 },
    },
    errors = {
      view = "popup",
      opts = { enter = true, format = "details" },
      filter = { error = true },
      filter_opts = { reverse = true },
    },
  },
  notify = {
    enabled = true,
    view = "notify",
  },
  lsp = {
    progress = {
      enabled = false,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    hover = {
      enabled = true,
      silent = true,
      view = "hover",
    },
    signature = {
      enabled = false,
    },
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  messages = {
    enabled = true,
    view = "mini",
    view_error = "mini",
    view_warn = "mini",
    view_history = "messages",
    view_search = "virtualtext",
  },
  markdown = {
    hover = {
      ["|(%S-)|"] = vim.cmd.help,
      ["%[.-%]%((%S-)%)"] = require("noice.util").open,
    },
    highlights = {
      ["|%S-|"] = "@text.reference",
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
    },
  },
  smart_move = {
    excluded_filetypes = dofile(args.exclude_ft_path),
  },
  throttle = 1000 / 30,
  health = {
    checker = false, -- for goneovim
  },
  views = {
    cmdline_popup = {
      border = {
        style = "single",
        -- padding = { 1, 1 },
      },
      filter_options = {},
      win_options = {
        winhighlight = {
          Normal = "NormalFloat",
          FloatBorder = "FloatBorder",
        },
      },
    },
    hover = {
      border = {
        style = "single",
      },
    },
  },
})

vim.keymap.set({ "n", "i", "s" }, "<C-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<C-f>"
  end
end, { silent = true, expr = true })
vim.keymap.set({ "n", "i", "s" }, "<C-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<C-b>"
  end
end, { silent = true, expr = true })
