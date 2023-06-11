{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-vim = { pkgs, ... }: {
    programs.vim = { enable = true; };
  };
}
