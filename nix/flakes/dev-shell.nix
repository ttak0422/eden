{ inputs, ... }: {
  perSystem = { config, pkgs, ... }: {
    devShells.default =
      pkgs.mkShell { packages = with pkgs; [ gnumake nixfmt pre-commit ]; };
  };
}
