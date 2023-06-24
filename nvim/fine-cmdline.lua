require("fine-cmdline").setup({
  cmdline = {
    enable_keymaps = false,
    smart_history = true,
    prompt = "",
  },
  popup = {
    position = {
      row = "10%",
      col = "50%",
    },
    size = {
      width = "60%",
    },
    border = {
      style = "single",
    },
    win_options = {
      winhighlight = "",
    },
    buf_options = {
      filetype = "FineCmdlinePrompt",
    },
  },
  hooks = {
    before_mount = function(input) end,
    after_mount = function(input)
      -- vim.api.nvim_buf_del_keymap(input.bufnr, "i", "<Tab>")
      vim.cmd([[autocmd BufLeave <buffer> :BufDel!]])
    end,
    set_keymaps = function(imap, feedkeys)
      local fn = require("fine-cmdline").fn
      imap("<Esc>", fn.close)
      imap("<C-c>", fn.close)
      -- imap("<C-w>", fn.close)
      imap("<Up>", fn.up_search_history)
      imap("<Down>", fn.down_search_history)
      imap("<Tab>", fn.complete_or_next_item)
      imap("<S-Tab>", fn.stop_complete_or_previous_item)
    end,
  },
})
