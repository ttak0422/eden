-- [nfnl] Compiled from nvim/fnl/hydra.fnl by https://github.com/Olical/nfnl, do not edit.
local hydra = require("hydra")
local cmd = (require("hydra.keymap-util")).cmd
do
  local heads
  local function _1_()
    return (require("smart-splits")).resize_left(2)
  end
  local function _2_()
    return (require("smart-splits")).resize_down(2)
  end
  local function _3_()
    return (require("smart-splits")).resize_up(2)
  end
  local function _4_()
    return (require("smart-splits")).resize_right(2)
  end
  heads = {{"h", "<C-w>h"}, {"j", "<C-w>j"}, {"k", "<C-w>k"}, {"l", "<C-w>l"}, {"H", cmd("WinShift left")}, {"J", cmd("WinShift down")}, {"K", cmd("WinShift up")}, {"L", cmd("WinShift right")}, {"<C-h>", _1_}, {"<C-j>", _2_}, {"<C-k>", _3_}, {"<C-l>", _4_}, {"=", "<C-w>=", {desc = "equalize"}}, {"z", cmd("NeoZoomToggle")}, {"q", cmd("SafeCloseWindow")}, {"<C-q>", cmd("SafeCloseWindow"), {desc = false}}, {"o", "<C-w>o", {desc = "close other", exit = true}}, {"<C-o>", "<C-w>o", {exit = true, desc = false}}, {"<Esc>", nil, {exit = true, desc = false}}, {"<CR>", nil, {exit = true, desc = false}}}
  hydra({name = "Window", mode = "n", body = "<C-w>", heads = heads})
end
return nil
