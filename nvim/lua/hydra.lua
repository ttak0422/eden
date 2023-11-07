-- [nfnl] Compiled from nvim/fnl/hydra.fnl by https://github.com/Olical/nfnl, do not edit.
local hydra = require("hydra")
local cmd = (require("hydra.keymap-util")).cmd
local config = {invoke_on_body = true, hint = false}
do
  local heads
  local function _1_()
    return (require("smart-splits")).start_resize_mode()
  end
  heads = {{"h", "<C-w>h", {exit = true}}, {"j", "<C-w>j", {exit = true}}, {"k", "<C-w>k", {exit = true}}, {"l", "<C-w>l", {exit = true}}, {"w", "<C-w>w", {exit = true}}, {"<C-w>", "<C-w>w", {exit = true, desc = false}}, {"<C-h>", "<C-w>h"}, {"<C-j>", "<C-w>j"}, {"<C-k>", "<C-w>k"}, {"<C-l>", "<C-w>l"}, {"H", cmd("WinShift left")}, {"J", cmd("WinShift down")}, {"K", cmd("WinShift up")}, {"L", cmd("WinShift right")}, {"e", _1_, {desc = "resize mode", exit = true}}, {"=", "<C-w>=", {desc = "equalize"}}, {"s", "<C-w>s", {exit = true, desc = false}}, {"v", "<C-w>v", {exit = true, desc = false}}, {"z", cmd("NeoZoomToggle"), {desc = "zoom"}}, {"q", cmd("SafeCloseWindow"), {exit = true, desc = "close"}}, {"<C-q>", cmd("SafeCloseWindow"), {exit = true, desc = false}}, {"o", "<C-w>o", {desc = "close other", exit = true}}, {"<C-o>", "<C-w>o", {exit = true, desc = false}}, {"<Esc>", nil, {exit = true, desc = false}}, {";", nil, {exit = true, desc = false}}, {"<CR>", nil, {exit = true, desc = false}}}
  hydra({name = "Windows", mode = "n", body = "<C-w>", heads = heads, config = config})
end
return nil
