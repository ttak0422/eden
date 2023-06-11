{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-core = { pkgs, ... }: { imports = [ ./zsh.nix ]; };
}
