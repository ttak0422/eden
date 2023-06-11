{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/tig.dhall);
in {
  home = {
    packages = with pkgs; [ tig ];
    file.".tigrc".text = prefs.config;
  };
}
