{ config, pkgs, lib, ... }: {
  home.packages = with pkgs.pkgs-unstable; [ zellij ];
  home.file.".config/zellij/config.kdl".text =
    builtins.readFile ./../../../configs/zellij/config.kdl;
  home.file.".config/zellij/layouts/default.kdl".text =
    builtins.readFile ./../../../configs/zellij/layouts/default.kdl;
}
