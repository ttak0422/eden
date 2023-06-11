{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-app = { ... }: { imports = [ ./wezterm.nix ]; };
}
