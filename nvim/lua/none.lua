-- [nfnl] Compiled from nvim/fnl/none.fnl by https://github.com/Olical/nfnl, do not edit.
local function is_active_lsp(lsp_name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.buf_get_clients(bufnr)
  local acc = false
  for _, client in ipairs(clients) do
    acc = (acc or (lsp_name == client.name))
  end
  return acc
end
local null = require("null-ls")
local utils = require("null-ls.utils")
local helpers = require("null-ls.helpers")
local formatter_factory = require("null-ls.helpers.formatter_factory")
local methods = require("null-ls.methods")
local FORMATTING = methods.internal.FORMATTING
local defaults = {border = nil, cmd = {"nvim"}, debounce = 250, default_timeout = 5000, diagnostic_config = {}, diagnostics_format = "#{m}", fallback_severity = vim.diagnostic.severity.ERROR, log_level = "warn", notify_format = "[null-ls] %s", on_attach = nil, on_init = nil, on_exit = nil, root_dir = utils.root_pattern({".null-ls-root", ".git"}), should_attach = nil, sources = nil, temp_dir = nil, update_in_insert = false, debug = false}
local dhall_format = {name = "dhall-format", method = {FORMATTING}, filetypes = {"dhall"}, generator = null.formatter({command = "dhall", args = {"format", "$FILENAME"}, to_stdin = true})}
local fnlfmt = {name = "fnlfmt", method = {FORMATTING}, filetypes = {"fennel"}, generator = null.formatter({command = "fnlfmt", args = {"$FILENAME"}, to_stdin = true})}
local sources
local function _1_(utils0)
  return utils0.root_has_file({"eslint.config.js", ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json"})
end
local function _2_(diagnostic)
  diagnostic.severity = vim.diagnostic.severity.WARN
  return nil
end
local function _3_()
  return (vim.fn.executable("cspell") > 0)
end
local function _4_(...)
  return is_active_lsp("vtsls")
end
local function _5_(...)
  return is_active_lsp("denols")
end
sources = {null.builtins.diagnostics.eslint.with({prefer_local = "node_modules/.bin", condition = _1_}), null.builtins.diagnostics.cspell.with({diagnostics_postprocess = _2_, condition = _3_}), null.builtins.formatting.tidy, null.builtins.formatting.fixjson, null.builtins.formatting.taplo, null.builtins.formatting.shfmt, null.builtins.formatting.stylua, null.builtins.formatting.yapf, null.builtins.formatting.google_java_format, null.builtins.formatting.nixfmt, null.builtins.formatting.dart_format, null.builtins.formatting.gofmt, null.builtins.formatting.rustfmt, null.builtins.formatting.yamlfmt, null.builtins.formatting.prettier.with({prefer_local = "node_modules/.bin", runtime_condition = _4_}), null.builtins.formatting.deno_fmt.with({runtime_condition = _5_}), dhall_format, fnlfmt}
null.setup({defaults = defaults, sources = sources})
vim.api.nvim_create_user_command("Format", "lua vim.lsp.buf.format()", {})
return nil
