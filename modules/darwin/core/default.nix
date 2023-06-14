{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-core = { pkgs, ... }: {
    imports = [
      ./dock.nix
      ./finder.nix
      ./keyboard.nix
      ./loginwindow.nix
      ./ng-global.nix
    ];
    services.nix-daemon.enable = true;
  programs.zsh = {
    enable = true;
    promptInit = "";
  };
  };
}
