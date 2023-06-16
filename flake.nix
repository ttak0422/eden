{
  description = "eden";

  inputs = {
    flake-parts.url = "flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
      };
    };
    vim-plugins-overlay.url = "github:ttak0422/vim-plugins-overlay";
    oboro-nvim = {
      url = "github:ttak0422/oboro-nvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        nix-filter.follows = "nix-filter";
      };
    };
    emacs.url = "github:cmacrae/emacs";

    # External packages.
    jol = {
      url =
        "https://repo.maven.apache.org/maven2/org/openjdk/jol/jol-cli/0.16/jol-cli-0.16-full.jar";
      flake = false;
    };
    tmux-pomodoro-plus = {
      url = "github:olimorris/tmux-pomodoro-plus";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      imports = [ ./flakes ./libs ./modules ];
    };
}
