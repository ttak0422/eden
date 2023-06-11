{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-ideavim = { pkgs, ... }:
    let vimrc = builtins.readFile ./../../../configs/ideavimrc.vim;
    in { home.file.".ideavimrc".text = vimrc; };
}
