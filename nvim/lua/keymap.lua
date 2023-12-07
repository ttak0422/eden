-- [nfnl] Compiled from nvim/fnl/keymap.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local key_opts = {noremap = true, silent = true}
local desc
local function _1_(d)
  return {noremap = true, silent = true, desc = d}
end
desc = _1_
local cmd
local function _2_(c)
  return ("<cmd>" .. c .. "<cr>")
end
cmd = _2_
local lua_cmd
local function _3_(c)
  return cmd(("lua " .. c))
end
lua_cmd = _3_
local map = vim.keymap.set
local n_keys
local function _4_()
  return vim.cmd(("Gin " .. vim.fn.input("git command: ")))
end
local function _5_()
  return vim.cmd(("GinBuffer " .. vim.fn.input("git command: ")))
end
n_keys = {{"q", "<nop>"}, {"<esc><esc>", cmd("nohl")}, {"j", "gj"}, {"k", "gk"}, {"<leader>m", lua_cmd("require('treesj').toggle()"), desc("toggle split/join")}, {"<leader>M", lua_cmd("require('treesj').toggle({ split = { recursive = true } })"), desc("toggle split/join rec")}, {"gpd", lua_cmd("require('goto-preview').goto_preview_definition()"), desc("preview definition")}, {"gpi", lua_cmd("require('goto-preview').goto_preview_implementation()"), desc("preview implementation")}, {"gpr", lua_cmd("require('goto-preview').goto_preview_references()"), desc("preview references")}, {"gP", lua_cmd("require('goto-preview').close_all_win()"), desc("close all preview")}, {"<leader>gg", _4_, desc("git command (echo)")}, {"<leader>gG", _5_, desc("git command (buffer)")}, {"<leader>gb", cmd("execute printf('Gina blame --width=%d', &columns / 3)"), desc("git blame")}, {"<leader>gs", cmd("GinStatus"), desc("git status")}, {"<leader>gl", cmd("GinLog"), desc("git log")}, {"<leader>G", cmd("Neogit"), desc("magit for vim")}, {"<leader>q", cmd("BufDel")}, {"<leader>Q", cmd("BufDel!")}, {"<leader>A", cmd("tabclose")}, {"<leader>E", cmd("FeMco"), desc("edit code block")}, {"<leader>br", lua_cmd("require('harpoon.mark').add_file()"), desc("register buffer (harpoon)")}, {"<leader>tc", cmd("ColorizerToggle"), desc("toggle colorize")}, {"<leader>tb", cmd("NvimTreeToggle")}, {"<leader>tB", cmd("Neotree", toggle)}, {"<leader>to", cmd("SidebarNvimToggle")}, {"<leader>tm", lua_cmd("require('codewindow').toggle_minimap()"), desc("toggle minimap")}, {"<leader>tr", lua_cmd("require('harpoon.ui').toggle_quick_menu()"), desc("toggle registered buffer menu")}, {"<leader>tg", cmd("TigTermToggle"), desc("toggle tig terminal")}, {"<leader>ff", cmd("Telescope live_grep_args"), desc("search by content")}, {"<leader>fp", cmd("Ddu -name=fd file_fd"), desc("search by file name")}, {"<leader>fP", cmd("Ddu -name=ghq ghq"), desc("search repo (ghq)")}, {"<leader>fb", cmd("Telescope buffers"), desc("search buffer")}, {"<leader>fh", cmd("Legendary"), desc("search legendary")}, {"<leader>ft", cmd("Telescope sonictemplate templates"), desc("search templates")}, {"<leader>fru", cmd("Ddu -name=mru mru"), desc("MRU (Most Recently Used files)")}, {"<leader>frw", cmd("Ddu -name=mrw mrw"), desc("MRW (Most Recently Written files)")}, {"<leader>frr", cmd("Ddu -name=mrr mrr"), desc("MRR (Most Recent git Repositories)")}, {"<leader>fF", lua_cmd("require('spectre').open()"), desc("find and replace with dark power")}}
for _, keymap in ipairs(n_keys) do
  map("n", keymap[1], keymap[2], (keymap[3] or key_opts))
end
for i = 0, 9 do
  map({"n", "t", "i"}, ("<C-" .. i .. ">"), cmd(("TermToggle " .. i)), desc(("toggle terminal " .. i)))
end
map({"n", "x"}, "gs", lua_cmd("require('reacher').start()"), desc("search displayed"))
return map({"n", "x"}, "gS", lua_cmd("require('reacher').start_multiple()"), desc("search displayed"))
