{ self, withSystem, inputs, ... }: {
  flake.nixosModules.eden-nixos-tool = withSystem "x86_64-linux"
    ({ system, ... }:
      { pkgs, lib, config, ... }: {
        environment.systemPackages = with pkgs; [ file ];
      });
}
