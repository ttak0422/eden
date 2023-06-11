{ pkgs, ... }: { home.packages = with pkgs; [ docker lazydocker ]; }
