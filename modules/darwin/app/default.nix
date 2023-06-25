{ self, withSystem, inputs, ... }: {
  flake.nixosModules.eden-darwin-app = withSystem "aarch64-darwin"
    ({ system, ... }:
      { pkgs, lib, config, username, ... }: {
        environment.systemPackages = with pkgs; [ wezterm raycast ];

        system.activationScripts.applications.text =
          let mkalias = inputs.mkAlias.outputs.apps.${system}.default.program;
          in lib.mkForce ''
            applications="$HOME/Applications"
            if ! test -d "$applications"; then
                mkdir -p "$applications"
                chown ${username}: "$applications"
                chmod u+w "$applications"
            fi

            app_path="$applications/Nix Apps Hack"
            tmp_path="$(mktemp -dt "darwin-applications.XXXX")" || exit 1

            find ${config.system.build.applications}/Applications/ -maxdepth 1 -type l 2>/dev/null | while IFS= read -r target_path
            do
              target_basename=$(basename $target_path)
              ${mkalias} -L "$target_path" "$tmp_path/$target_basename"
            done

            rm -rf "$app_path"
            mv "$tmp_path" "$app_path"
            chown ${username}: "$app_path"
            chmod u+w "$app_path"
          '';
      });
}
