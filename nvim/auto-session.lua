vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup({
  log_level = "error",
  cwd_change_handling = {
    restore_upcoming_session = false,
    pre_cwd_changed_hook = nil,
    post_cwd_changed_hook = nil,
  },
  session_lens = {
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_session_create_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = false,
  auto_session_use_git_branch = true,
})
