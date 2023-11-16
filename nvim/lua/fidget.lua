-- [nfnl] Compiled from nvim/fnl/fidget.fnl by https://github.com/Olical/nfnl, do not edit.
local fidget = require("fidget")
local progress
local function _1_(msg)
  return msg.lsp_name
end
progress = {poll_rate = 2, suppress_on_insert = true, ignore_done_already = true, notification_group = _1_, ignore = {}}
local display
local function _2_(msg)
  return msg.title
end
local function _3_(grp)
  return tostring(grp)
end
display = {render_limit = 10, done_ttl = 3, done_icon = "\226\156\148", done_style = "Constant", progress_ttl = 40, progress_icon = {pattern = "dots", period = 1}, progress_style = "WarningMsg", group_style = "Title", icon_style = "Question", priority = 30, format_message = (require("fidget.progress.display")).default_format_message, format_annote = _2_, format_group_name = _3_, overrides = {rust_analyzer = {name = "rust-analyzer"}}}
local notification = {poll_rate = 2, filter = vim.log.levels.INFO, configs = {default = fidget.default_config}, view = {stack_upwards = true, icon_separator = " ", group_separator = "---", group_separator_hl = "Comment"}, window = {normal_hl = "Comment", winblend = 100, border = "none", zindex = 45, max_width = 0, max_height = 0, x_padding = 1, y_padding = 0, align_bottom = true, relative = "editor"}, override_vim_notify = false}
local logger = {level = vim.log.levels.WARN, float_precision = 0.01, path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache"))}
return fidget:setup({progress = progress, display = display, notification = notification, logger = logger})
