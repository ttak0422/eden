{ inputs, ... }:
let
  inherit (inputs) nixpkgs darwin home-manager;
  mkConfiguration = { system, userName, hmConfig ? ./../../hm/minimal.nix
    , hmStateVersion, specialArgs ? { }, modules ? [ ], hmModules ? [ ], ... }:
    let
      pkgs = import nixpkgs { inherit system; };
      inherit (pkgs.stdenv) isDarwin;
    in (if isDarwin then darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem) {
      inherit system;
      modules = modules ++ (if isDarwin then
        [ home-manager.darwinModules.home-manager ]
      else
        [ home-manager.nixosModules.home-manager ]) ++ [{
          users.users.${userName}.home =
            if isDarwin then "/Users/${userName}" else "wip";
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            users.${userName} = {
              imports = [ ./../../prelude.nix hmConfig ] ++ hmModules;
              home.stateVersion = hmStateVersion;
            };
            extraSpecialArgs = specialArgs;
          };
        }];
    };

  hmStateVersion = "23.05";
  userName = "ttak0422";
  userEmail = "ttak0422@gmail.com";
in {
  flake = {
    darwinConfigurations = {
      darwin-m1 = mkConfiguration {
        inherit userName hmStateVersion;
        system = "aarch64-darwin";
        hmConfig = ./../../hm/personal.nix;
        modules = [{ services.nix-daemon.enable = true; }];
        specialArgs = { inherit userName userEmail; };
      };
    };
  };
}
