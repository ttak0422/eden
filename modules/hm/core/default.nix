{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-core = { pkgs, ... }: {
    imports = [ ./zsh.nix ];
    home.packages = with pkgs; [ cachix ];
  };
}
