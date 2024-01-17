{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [
  # vim-sensible
  # {
  #   plugin = alpha-nvim;
  #   startupConfig = readFile ./../../../nvim/alpha.lua;
  # }
  {
    plugin = kanagawa-nvim;
    startupConfig = {
      language = "lua";
      code = readFile ./../../../nvim/kanagawa.lua;
    };
  }
  {
    plugin = nvim-config-local;
    startupConfig = {
      language = "lua";
      code = readFile ./../../../nvim/config-local.lua;
    };
  }
  {
    plugin = stickybuf-nvim;
    startupConfig = {
      language = "lua";
      code = readFile ./../../../nvim/stickybuf.lua;
    };
  }
  {
    plugin = direnv-vim;
    startupConfig = {
      language = "lua";
      code = readFile ./../../../nvim/direnv.lua;
    };
  }
  {
    plugin = hydra-nvim;
    startupConfig = {
      language = "lua";
      code = readFile ./../../../nvim/lua/hydra.lua;
    };
  }
]
