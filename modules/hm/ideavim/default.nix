{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-vim = { pkgs, ... }: {
    home.file.".ideavimrc".text = builtins.readFile ./ideavimrc.vim;
  };
}
