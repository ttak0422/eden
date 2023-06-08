{ self, withSystem, moduleWithSystem, inputs, ... }:
let
  inherit (inputs) nixpkgs darwin home-manager;

  mkHmModule = { username, stateVersion, isDarwin, modules ? [ ]
    , extraSpecialArgs ? { }, sharedModules ? [ ] }: {
      home-manager = {
        inherit extraSpecialArgs sharedModules;
        useUserPackages = true;
        useGlobalPkgs = true;
        users.${username} = {
          imports = modules;
          home = { inherit username stateVersion; };
        };
      };
    };

  mkConfiguration = { username, system, modules, hmStateVersion, hmModules ? [ ]
    , extraSpecialArgs ? { }, sharedModules ? [ ] }:
    let
      pkgs = import nixpkgs { inherit system; };
      inherit (pkgs.stdenv) isDarwin;
    in (if isDarwin then darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem) {
      inherit system;

      modules = [
        (mkHmModule {
          inherit username extraSpecialArgs sharedModules isDarwin;
          stateVersion = hmStateVersion;
          modules = hmModules;
        })
      ] ++ modules;
    };

  hmStateVersion = "23.05";
  username = "ttak0422";
  userEmail = "ttak0422@gmail.com";

in {
  flake = {
    darwinConfigurations = withSystem "aarch64-darwin"
      ({ self', inputs', system, ... }: {
        aarch64-darwin = mkConfiguration {
          inherit system username hmStateVersion;

          modules = [
            home-manager.darwinModules.home-manager
            {
              services.nix-daemon.enable = true;
              users.users.${username}.home = "/Users/${username}";
            }
          ];
          hmModules = [ self.homeManagerModules.core ];
          extraSpecialArgs = { inherit username userEmail; };
        };
      });
  };
}
