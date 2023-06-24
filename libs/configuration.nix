{ inputs, ... }: {
  flake.lib = let
    inherit (inputs.darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    mkHmModule = { pkgs, username, stateVersion, modules ? [ ]
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

    mkConfiguration = { system, pkgs, modules, specialArgs ? { } }:
      let inherit (pkgs.stdenv) isDarwin;
      in (if isDarwin then darwinSystem else nixosSystem) {
        inherit system modules specialArgs;
      };
  };
}
