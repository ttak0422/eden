{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-nvim = { pkgs, ... }: {
    home.file."nvim".txt = "nvim";
  };
}
