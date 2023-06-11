{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/skhd.dhall);
in {
  services.skhd = {
    enable = true;
    skhdConfig = prefs.config;
  };
}
