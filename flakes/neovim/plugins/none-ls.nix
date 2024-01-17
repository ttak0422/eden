{ pkgs, vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  plugin = none-ls-nvim;
  dependPlugins = [ plenary-nvim ];
  postConfig = {
    language = "lua";
    code = readFile ./../../../nvim/lua/none.lua;
  };
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
  useTimer = true;
}]
