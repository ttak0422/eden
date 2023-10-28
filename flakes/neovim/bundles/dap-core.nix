{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  name = "dap";
  plugins =
    [ nvim-dap nvim-dap-go nvim-dap-ui nvim-dap-virtual-text overseer-nvim ];
  dependBundles = [ "treesitter" ];
  config = readFile ./../../../nvim/dap.lua;
  modules = [ "dap" "dapui" ];
  filetypes = [ "java" ];
}]
