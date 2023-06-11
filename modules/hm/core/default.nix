{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-core = { pkgs, ... }: {
    imports = [ ./tmux.nix ./zsh.nix ];
    home.packages = with pkgs; [ cachix ];
  };
}
