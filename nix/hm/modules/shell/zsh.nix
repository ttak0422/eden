{ config, pkgs, lib, ... }:
let
  prefs =
    pkgs.dhallToNix (builtins.readFile ./../../../../prefs/shell/zsh/zsh.dhall);
in {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = prefs.alias;
      initExtra = ''
        ${prefs.bindkey.emacs}
        ${prefs.history}
      '';
    };
  };
  home.packages = with pkgs; [ bat exa ghq ];
}
