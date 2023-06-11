{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-virtualization = { pkgs, ... }: {
    imports = [ ./docker.nix ./k8s.nix ];
  };
}
