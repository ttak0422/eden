{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ nodePackages.npm nodejs yarn ];
    file.".npmrc".text = builtins.readFile ./../../../configs/.npmrc;
  };

}
