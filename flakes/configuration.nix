{ self, withSystem, inputs, ... }:
let
  inherit (self.lib) mkConfiguration mkHmModule;

  hmStateVersion = "23.05";
  username = "ttak0422";
  userEmail = "ttak0422@gmail.com";

  flags = { copilot = true; };

in {
  # imports = [
  #   inputs.bundler.flakeModules.nvim
  # ];
  flake = {
    darwinConfigurations = withSystem "aarch64-darwin"
      ({ self', inputs', system, pkgs, ... }: {
        aarch64-darwin = mkConfiguration {
          inherit system pkgs flags;

          specialArgs = { inherit username; };

          modules = [
            inputs.home-manager.darwinModules.home-manager
            self.nixosModules.eden-core
            self.nixosModules.eden-darwin-app
            self.nixosModules.eden-darwin-core
            self.nixosModules.eden-darwin-desktop
            self.nixosModules.eden-darwin-development
            self.nixosModules.eden-darwin-emacs
            self.nixosModules.eden-darwin-homebrew

            {
              nixpkgs = {
                overlays = builtins.attrValues self.overlays ++ [ ];
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [ "openssl-1.1.1u" ];
                };
              };
              users.users.${username}.home = "/Users/${username}";
              environment.systemPackages = [
                (pkgs.runCommand "nvim" { } ''
                  mkdir -p $out/bin
                  ln -s ${
                    self.packages.${system}.bundler-nvim
                  }/bin/nvim $out/bin/nvim
                '')
              ];
            }

            (mkHmModule {
              inherit pkgs username flags;
              stateVersion = hmStateVersion;
              modules = [
                inputs.oboro-nvim.homeManagerModules.${system}.default
                self.nixosModules.eden-hm-core
                self.nixosModules.eden-hm-app
                self.nixosModules.eden-hm-darwin
                self.nixosModules.eden-hm-development
                self.nixosModules.eden-hm-emacs
                # self.nixosModules.eden-hm-doom-emacs
                self.nixosModules.eden-hm-git
                self.nixosModules.eden-hm-ideavim
                self.nixosModules.eden-hm-tool
                self.nixosModules.eden-hm-nvim
                self.nixosModules.eden-hm-tool
                self.nixosModules.eden-hm-vim
                self.nixosModules.eden-hm-virtualization
              ];
              extraSpecialArgs = { inherit system username userEmail; };
            })
          ];
        };
      });
  };
}
