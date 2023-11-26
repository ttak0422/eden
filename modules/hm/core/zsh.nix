{ config, pkgs, lib, ... }:
let
  prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/zsh.dhall);
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib.attrsets) optionalAttrs;
in {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = prefs.aliases
        // (optionalAttrs isDarwin prefs.darwinAliases);
      initExtra = ''
        ${prefs.bindkey.emacs}
        ${prefs.history}
        ${prefs.sharedPath}
        ${if isDarwin then prefs.darwinPath else ""}
        ${prefs.function}
        ${if isDarwin then prefs.darwinFunction else ""}

        # pure
        fpath+=("$HOME/.zsh/plugins/pure/share/zsh/site-functions")
        autoload -U promptinit; promptinit
        zstyle :prompt:error color '#F5C77E'
        zstyle :prompt:success color '#87CEEB'
        PURE_PROMPT_SYMBOL="❯❯❯"

        prompt pure
      '';
      profileExtra = ''
        ${prefs.sharedProfile}
        ${if isDarwin then prefs.darwinProfile else ""}
      '';
      plugins = [{
        name = "pure";
        src = pkgs.pure-prompt;
        file = "share/zsh/site-functions";
      }];
    };
  };
  home.packages = with pkgs; [ bat exa ghq ];
}
