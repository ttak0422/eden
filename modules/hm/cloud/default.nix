{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-cloud = { pkgs, ... }: {
    home.packages = with pkgs; [ google-cloud-sdk ];
  };
}
