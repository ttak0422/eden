_: {
  flake.nixosModules.eden-hm-darwin = { pkgs, lib, ... }: {
    home = lib.mkIf pkgs.stdenv.isDarwin {
      # https://texwiki.texjp.org/?Mac#defaultkeybinding-dict
      file."/Library/KeyBindings/DefaultKeyBinding.dict".text =
        builtins.readFile ./../../../configs/DefaultKeyBinding.dict;
      file."Library/LaunchAgents/Neovide.plist".text =
        builtins.readFile ./../../../configs/Neovide.plist;
    };
  };
}
