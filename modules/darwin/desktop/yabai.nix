{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./../../../configs/yabai.dhall);
in {
  services.yabai = {
    enable = true;
    enableScriptingAddition = false;
    extraConfig = prefs.config;
  };
}
