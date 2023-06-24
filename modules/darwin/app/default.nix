{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-app = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ ];
  };
}
