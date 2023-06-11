{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-homebrew = { pkgs, ... }: {
    homebrew = {
      enable = true;
      onActivation = { cleanup = "zap"; };
      global = { brewfile = true; };
    } // (pkgs.dhallToNix (builtins.readFile ./personal.dhall));
  };
}
