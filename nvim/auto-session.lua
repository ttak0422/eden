vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup({
  log_level = "error",
  cwd_change_handling = nil,
  session_lens = {
    load_on_setup = true,
    theme_conf = require("telescope.themes").get_ivy({
      path_display = { "truncate" },
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<C-j>"] = { "<Plug>(skkeleton-enable)", type = "command" },
        },
      },
    }),
    previewer = false,
  },
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_session_create_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = false,
  auto_session_use_git_branch = true,
})
