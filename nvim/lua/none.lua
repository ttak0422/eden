-- [nfnl] Compiled from nvim/fnl/none.fnl by https://github.com/Olical/nfnl, do not edit.
local null = require("null-ls")
local utils = require("null-ls.utils")
local methods = require("null-ls.methods")
local FORMATTING = methods.internal.FORMATTING
local defaults = {border = nil, cmd = {"nvim"}, debounce = 250, default_timeout = 5000, diagnostic_config = {}, diagnostics_format = "#{m}", fallback_severity = vim.diagnostic.severity.ERROR, log_level = "warn", notify_format = "[null-ls] %s", on_attach = nil, on_init = nil, on_exit = nil, root_dir = utils.root_pattern({".null-ls-root", ".git"}), should_attach = nil, sources = nil, temp_dir = nil, debug = false, update_in_insert = false}
local fnlfmt = {name = "fnlfmt", method = {FORMATTING}, filetypes = {"fennel"}, generator = null.formatter({command = "fnlfmt", args = {"$FILENAME"}, to_stdin = true})}
local sources = {null.builtins.diagnostics.eslint.with({prefer_local = "node_modules/.bin"}), fnlfmt}
null.setup({defaults = defaults, sources = sources})
return nil
