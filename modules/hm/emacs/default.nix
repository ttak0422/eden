{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-emacs = { pkgs, ... }: {
    home.file."emacs".text = "emacs";
  };
}
