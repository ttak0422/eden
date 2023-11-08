local config = require("lsp-timeout.config").Config
config:new(vim.g.lspTimeoutConfig):validate()
