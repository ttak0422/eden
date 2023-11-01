vim.g.lspTimeoutConfig = {
  stopTimeout = 1000 * 60 * 30,
  startTimeout = 1000 * 10,
  silent = false,
  filetypes = {
    ignore = { "java" },
  },
}
