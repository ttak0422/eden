{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-desktop = {
    imports = [ ./skhd.nix ./spacebar.nix ./yabai.nix ];
  };
}
