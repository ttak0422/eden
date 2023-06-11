{ self, self', withSystem, moduleWithSystem, inputs, ... }:
let
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
            inputs.home-manager.darwinModules.home-manager
            self.nixosModules.eden-darwin-core
            self.nixosModules.eden-darwin-desktop
            self.nixosModules.eden-darwin-development
            self.nixosModules.eden-darwin-homebrew
            { users.users.${username}.home = "/Users/${username}"; }
          ];
          hmModules = [
            self.nixosModules.eden-hm-core
            self.nixosModules.eden-hm-app
            self.nixosModules.eden-hm-development
            self.nixosModules.eden-hm-emacs
            self.nixosModules.eden-hm-git
            self.nixosModules.eden-hm-ideavim
            self.nixosModules.eden-hm-tool
            self.nixosModules.eden-hm-nvim
            self.nixosModules.eden-hm-tool
            self.nixosModules.eden-hm-vim
            self.nixosModules.eden-hm-virtualization
          ];
          extraSpecialArgs = { inherit username userEmail; };
        };
      });
  };
}
