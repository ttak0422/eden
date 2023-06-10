{ self, self', withSystem, moduleWithSystem, inputs, ... }:
let
  inherit (inputs) home-manager;
  inherit (self.lib) mkConfiguration;

  hmStateVersion = "23.05";
  username = "ttak0422";
  userEmail = "ttak0422@gmail.com";

in {
  flake = {
    darwinConfigurations = withSystem "aarch64-darwin"
      ({ self', inputs', system, pkgs, ... }: {
        aarch64-darwin = mkConfiguration {
          inherit system pkgs username hmStateVersion;

          modules = [
            home-manager.darwinModules.home-manager
            {
              services.nix-daemon.enable = true;
              users.users.${username}.home = "/Users/${username}";
            }
          ];
          hmModules = [ self.homeManagerModules.eden.core ];
          extraSpecialArgs = { inherit username userEmail; };
        };
      });
  };
}
