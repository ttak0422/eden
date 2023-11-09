{ pkgs, vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  plugin = none-ls-nvim;
  depends = [ plenary-nvim ];
  config = readFile ./../../../nvim/lua/none.lua;
  extraPackages = with pkgs;
    [
      # TODO: add rules
      nodePackages.textlint
    ];
  lazy = true;
}]
