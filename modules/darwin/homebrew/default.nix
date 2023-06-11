{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-homebrew = { pkgs, ... }:
    let
      prefs =
        pkgs.dhallToNix (builtins.readFile ./../../../configs/homebrew.dhall);
    in {
      homebrew = {
        inherit (prefs) taps brews casks;
        enable = true;
        onActivation = { cleanup = "zap"; };
        global = { brewfile = true; };
      };
    };
}
