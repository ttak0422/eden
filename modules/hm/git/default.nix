{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-git = { pkgs, ... }: {
    imports = [ ./git.nix ./tig.nix ];
  };
}
