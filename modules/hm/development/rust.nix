{ pkgs, ... }:
let prefs = pkgs.dhallToNix (builtins.readFile ./rust.dhall);
in {
  home = {
    packages = with pkgs; [
      rustup
      # ↓ Rust REPL
      evcxr
    ];
    file = { ".cargo/config".text = prefs.cargo; };
  };
}
