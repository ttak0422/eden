-- [nfnl] Compiled from nvim/fnl/hydra.fnl by https://github.com/Olical/nfnl, do not edit.
local hydra = require("hydra")
local cmd = (require("hydra.keymap-util")).cmd
local config = {invoke_on_body = true, hint = false}
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
  heads = {{"h", "<C-w>h"}, {"j", "<C-w>j"}, {"k", "<C-w>k"}, {"l", "<C-w>l"}, {"w", "<C-w>w"}, {"<C-w>", "<C-w>w", {desc = false}}, {"H", cmd("WinShift left")}, {"J", cmd("WinShift down")}, {"K", cmd("WinShift up")}, {"L", cmd("WinShift right")}, {"<C-h>", _1_}, {"<C-j>", _2_}, {"<C-k>", _3_}, {"<C-l>", _4_}, {"=", "<C-w>=", {desc = "equalize"}}, {"s", "<C-w>s", {exit = true, desc = false}}, {"v", "<C-w>v", {exit = true, desc = false}}, {"z", cmd("NeoZoomToggle"), {desc = "zoom"}}, {"q", cmd("SafeCloseWindow"), {exit = true, desc = "close"}}, {"<C-q>", cmd("SafeCloseWindow"), {exit = true, desc = false}}, {"o", "<C-w>o", {desc = "close other", exit = true}}, {"<C-o>", "<C-w>o", {exit = true, desc = false}}, {"<Esc>", nil, {exit = true, desc = false}}, {"<CR>", nil, {exit = true, desc = false}}}
  hydra({name = "Windows", mode = "n", body = "<C-w>", heads = heads, config = config})
end
return nil
