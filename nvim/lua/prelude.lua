-- [nfnl] Compiled from nvim/fnl/prelude.fnl by https://github.com/Olical/nfnl, do not edit.
local cache_path = vim.fn.stdpath("cache")
for k, v in pairs({helplang = "ja", mouse = "a", ignorecase = true, smartcase = true, hlsearch = true, incsearch = true, hidden = true, termguicolors = true, autoread = true, showmatch = true, completeopt = "menu,menuone,noinsert", number = true, signcolumn = "yes", virtualedit = "block", cmdheight = 0, laststatus = 3, undofile = true, undodir = (cache_path .. "/undo"), swapfile = true, directory = (cache_path .. "/swap"), winwidth = 20, winminwidth = 20, expandtab = true, tabstop = 2, shiftwidth = 2, foldlevel = 99, foldlevelstart = 99, backup = true, backupcopy = "yes", backupdir = (cache_path .. "/backup"), diffopt = "internal,filler,closeoff,vertical", startofline = false, showmode = false, equalalways = false}) do
  vim.o[k] = v
end
return nil
