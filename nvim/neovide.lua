-- properties
vim.o.guifont = "PlemolJP Console NF:h18 "
vim.g.neovide_input_ime = false
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_fullscreen = false

local scale_delta = 1.1

-- helper functions
local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

local toggle_zoom = (function()
  return function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end
end)()

-- apply
vim.keymap.set({"n", "i", "c"}, "¥", "\\")
vim.keymap.set("n", "<C-+>", function()
  change_scale_factor(scale_delta)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / scale_delta)
end)
vim.keymap.set("n", "<A-Enter>", toggle_zoom)

vim.api.nvim_create_user_command("ToggleNeovideFullScreen", toggle_zoom, {})
