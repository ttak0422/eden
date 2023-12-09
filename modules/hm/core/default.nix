{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-core = { pkgs, ... }: {
    imports = [ ./mcfly.nix ./tmux.nix ./zsh.nix ./zellij.nix ];
    home.packages = with pkgs; [ cachix ];
  };
}
