{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [
  vim-sensible
  {
    plugin = kanagawa-nvim;
    startup = readFile ./../../nvim/kanagawa.lua;
  }
  {
    plugin = nvim-config-local;
    startup = readFile ./../../nvim/config-local.lua;
  }
  {
    plugin = stickybuf-nvim;
    startup = readFile ./../../nvim/stickybuf.lua;
  }
  {
    plugin = direnv-vim;
    startup = readFile ./../../nvim/direnv.lua;
  }
]
