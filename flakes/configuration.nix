{ self, withSystem, inputs, ... }:
let
  inherit (self.lib) mkConfiguration mkHmModule;

  hmStateVersion = "23.11";
  username = "ttak0422";
  userEmail = "ttak0422@gmail.com";

  flags = { copilot = true; };

in {
  flake = {
    nixosConfigurations = withSystem "x86_64-linux"
      ({ self', inputs', system, pkgs, ... }: {
        wsl = inputs.nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            inputs.nixos-wsl.nixosModules.wsl
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            inputs.nixpkgs.nixosModules.notDetected
            inputs.home-manager.nixosModules.home-manager
            self.nixosModules.eden-core
            self.nixosModules.eden-nixos-core

            {
              wsl = {
                enable = true;
                defaultUser = "${username}";
                startMenuLaunchers = true;
              };
              system.stateVersion = hmStateVersion;
              users.users."${username}" = {
                isNormalUser = true;
                group = "users";
                extraGroups = [ "wheel" ];
                createHome = true;
                home = "/home/${username}";
              };
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
                self.nixosModules.eden-hm-git
                self.nixosModules.eden-hm-core
                self.nixosModules.eden-hm-cloud
                self.nixosModules.eden-hm-app
                self.nixosModules.eden-hm-development
                # self.nixosModules.eden-hm-emacs
                # self.nixosModules.eden-hm-doom-emacs
                self.nixosModules.eden-hm-git
                self.nixosModules.eden-hm-ideavim
                self.nixosModules.eden-hm-tool
                self.nixosModules.eden-hm-vim
                self.nixosModules.eden-hm-virtualization
              ];
              extraSpecialArgs = { inherit inputs system username userEmail; };
            })
          ];
        };

      });

    darwinConfigurations = withSystem "aarch64-darwin"
      ({ self', inputs', system, pkgs, ... }: {
        aarch64-darwin = mkConfiguration {
          inherit system pkgs flags;

          specialArgs = { inherit inputs username; };

          modules = [
            inputs.home-manager.darwinModules.home-manager
            self.nixosModules.eden-core
            self.nixosModules.eden-darwin-app
            self.nixosModules.eden-darwin-core
            self.nixosModules.eden-darwin-desktop
            self.nixosModules.eden-darwin-development
            # self.nixosModules.eden-darwin-emacs
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
                self.nixosModules.eden-hm-core
                self.nixosModules.eden-hm-cloud
                self.nixosModules.eden-hm-app
                self.nixosModules.eden-hm-darwin
                self.nixosModules.eden-hm-development
                # self.nixosModules.eden-hm-emacs
                # self.nixosModules.eden-hm-doom-emacs
                self.nixosModules.eden-hm-git
                self.nixosModules.eden-hm-ideavim
                self.nixosModules.eden-hm-tool
                self.nixosModules.eden-hm-tool
                self.nixosModules.eden-hm-vim
                self.nixosModules.eden-hm-virtualization
              ];
              extraSpecialArgs = { inherit inputs system username userEmail; };
            })
          ];
        };
      });
  };
}
