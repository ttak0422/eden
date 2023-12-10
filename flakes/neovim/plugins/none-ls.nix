{ pkgs, vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  plugin = none-ls-nvim;
  depends = [ plenary-nvim ];
  config = readFile ./../../../nvim/lua/none.lua;
  extraPackages = with pkgs; [
    nodePackages.eslint
    nodePackages.cspell
    # TODO: add rules
    nodePackages.textlint
    # formatter
    google-java-format
    html-tidy
    nixfmt
    nodePackages.fixjson
    nodePackages.prettier
    rustfmt
    shfmt
    stylua
    taplo
    yamlfmt
    yapf
    dhall
    fnlfmt
  ];
  lazy = true;
}]
