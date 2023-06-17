{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-doom-emacs = { pkgs, ... }: {
    imports = [ inputs.nix-doom-emacs.hmModule ];
    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./../doom-emacs;
    };
  };
}
