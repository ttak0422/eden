{ self, inputs, ... }: {
  flake.homeManagerModules.core = { imports = [ ./zsh.nix ]; };
}
