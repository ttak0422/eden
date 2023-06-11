{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-development = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ cocoapods ];
  };
}
