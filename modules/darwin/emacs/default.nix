{ self, inputs, ... }: {
  flake.nixosModules.eden-darwin-emacs = { pkgs, ... }: {
    services.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };
}
