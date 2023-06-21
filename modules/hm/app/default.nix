{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-app = { pkgs, ... }: {
    imports = [ ./wezterm.nix ];
    home.packages = with pkgs; [ neovide ];
  };
}
