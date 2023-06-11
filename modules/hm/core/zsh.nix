{ config, pkgs, lib, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/zsh.dhall);
in {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = prefs.aliases;
      initExtra = ''
        ${prefs.bindkey.emacs}
        ${prefs.history}
      '';
    };
  };
  home.packages = with pkgs; [ bat exa ghq ];
}
