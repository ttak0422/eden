{ config, pkgs, lib, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/zsh.dhall);
inherit (pkgs.stdenv) isDarwin;
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
        ${prefs.sharedPath}
        ${if isDarwin then prefs.darwinPath else ""}
      '';
    };
  };
  home.packages = with pkgs; [ bat exa ghq ];
}
