{ self, inputs, ... }: {
  flake.nixosModules.eden-nixos-core = { pkgs, ... }: {
    imports = [ ];
    programs.zsh = {
      enable = true;
      promptInit = "";
    };
  };
}
