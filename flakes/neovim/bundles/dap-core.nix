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
  dependBundles = [ "treesitter" ];
  config = readFile ./../../../nvim/lua/dap.lua;
  lazy = true;
}]
