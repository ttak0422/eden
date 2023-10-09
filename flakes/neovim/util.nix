{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  # quickfixの高さを調整
  plugin = qfheight-nvim;
  config = readFile ./../../nvim/qfheight.lua;
  filetypes = [ "qf" ];
  events = [ "QuickFixCmdPre" ];
}]
