{ config, pkgs, lib, ... }: {
  programs.mcfly = {
    enable = true;
    keyScheme = "vim";
  };
}
