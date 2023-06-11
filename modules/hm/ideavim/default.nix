{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-ideavim = { pkgs, ... }: {
    home.file.".ideavimrc".text = builtins.readFile ./ideavimrc.vim;
  };
}
