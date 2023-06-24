{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-app = { system, pkgs, config, lib, ... }: {
    imports = [ ./wezterm.nix ];
    home = {
      packages = with pkgs;
        [
          # neovide
        ];

      activation.aliasApplications = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        (let
          apps = pkgs.buildEnv {
            name = "home-manager-applications";
            paths = config.home.packages;
            pathsToLink = "/Applications";
          };
          mkalias = inputs.mkAlias.outputs.apps.${system}.default.program;
        in lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          echo "Linking Home Manager applications..." 2>&1
          app_path="$HOME/Applications/Home Manager Apps Hack"
          tmp_path="$(mktemp -dt "home-manager-applications.XXXXXXXXXX")" || exit 1
          ${pkgs.fd}/bin/fd \
          -t l -d 1 . ${apps}/Applications \
          -x $DRY_RUN_CMD ${mkalias} -L {} "$tmp_path/{/}"
          $DRY_RUN_CMD rm -rf "$app_path"
          $DRY_RUN_CMD mv "$tmp_path" "$app_path"
        '');
    };
  };
}
