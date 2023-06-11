{ self, inputs, ... }: {
  flake.nixosModules.eden-hm-development = { pkgs, ... }: {
    imports = [
      ./cue.nix
      ./deno.nix
      ./dhall.nix
      ./dotnet.nix
      ./elm.nix
      ./go.nix
      ./haskell.nix
      ./java.nix
      ./lua.nix
      ./nix.nix
      ./node.nix
      ./python.nix
      ./rust.nix
      ./scala.nix
    ];
  };
}
