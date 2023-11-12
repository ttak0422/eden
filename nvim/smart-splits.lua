require("smart-splits").setup({
  resize_mode = {
    silent = true,
    quit_key = "<ESC>",
    resize_keys = { "h", "j", "k", "l" },
    hooks = {
      on_enter = function()
        vim.notify("Entering resize mode")
      end,
      on_leave = function()
        require("bufresize").register()
        vim.notify("Exiting resize mode")
      end,
    },
  },
})
