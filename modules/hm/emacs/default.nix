{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-emacs = { pkgs, ... }: {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraConfig = ''
        ${builtins.readFile ./../../../emacs/early-init.el}
        ${builtins.readFile ./../../../emacs/init.el}
      '';
      extraPackages = epkgs: with pkgs.emacsPackages; [ vterm ];
    };
    home.file."emacs".text = "emacs";
  };
}
