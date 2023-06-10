{ inputs, ... }: {
  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [ gnumake ls-lint nixfmt pre-commit ];
    };
  };
}
