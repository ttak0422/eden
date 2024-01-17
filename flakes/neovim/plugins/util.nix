{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  # quickfixの高さを調整
  plugin = qfheight-nvim;
  postConfig = {language="lua";code=readFile ./../../../nvim/qfheight.lua;};
  onFiletypes = [ "qf" ];
  onEvents = [ "QuickFixCmdPre" ];
}]
