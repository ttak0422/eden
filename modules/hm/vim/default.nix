{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-vim = { pkgs, ... }: {
    programs.vim = {
      enable = true;
      extraConfig = builtins.readFile ./../../../vim/init.vim;
    };
  };
}
