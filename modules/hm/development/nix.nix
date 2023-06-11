{ pkgs, ... }: {
  home.packages = with pkgs; [ nixpkgs-fmt deadnix statix nil ];
}
