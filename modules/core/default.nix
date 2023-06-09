{ self, inputs, ... }: {
  flake.homeManagerModules.eden.core = { imports = [ ./zsh.nix ]; };
}
