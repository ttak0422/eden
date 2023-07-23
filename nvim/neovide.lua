vim.o.guifont = "PlemolJP Console NF:h18 "
vim.g.neovide_input_ime = false
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_input_macos_alt_is_meta = true

local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-+>", function() change_scale_factor(1.25) end)
vim.keymap.set("n", "<C-->", function() change_scale_factor(1/1.25) end)
