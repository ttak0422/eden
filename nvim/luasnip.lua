local ls = require("luasnip")
local opts = { noremap = true, silent = true }

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  ls.jump(-1)
end, opts)

require("luasnip.loaders.from_vscode").lazy_load()
