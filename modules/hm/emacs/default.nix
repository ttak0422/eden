{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-emacs = { pkgs, ... }: {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraConfig = "";
      extraPackages = epkgs: with pkgs.emacsPackages; [ vterm ];
    };
    home = {
      packages = with pkgs; [ libgccjit ];
      file.".emacs.d/early-init.el".text =
        builtins.readFile ./../../../emacs/early-init.el;
      file.".emacs.d/init.el".text = builtins.readFile ./../../../emacs/init.el;
    };
  };
}
