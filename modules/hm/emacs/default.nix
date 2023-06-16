{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-emacs = { pkgs, ... }: {
    programs.emacs = {
      enable = true;
      extraConfig = builtins.readFile ./../../../emacs/init.el;
    };
    home.file."emacs".text = "emacs";
  };
}
