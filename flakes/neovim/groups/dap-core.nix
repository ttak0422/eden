{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  name = "dap";
  plugins = [
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-repl-highlights
    nvim-dap-go
    overseer-nvim
  ];
  dependGroups = [ "treesitter" ];
  postConfig = {
    language = "lua";
    code = readFile ./../../../nvim/lua/dap.lua;
  };
  useTimer = true;
}]
