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
    nifoc-overlay = {
      url = "github:nifoc/nix-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #      _                     _
    #   __| | __ _ _ ____      _(_)_ __
    #  / _` |/ _` | '__\ \ /\ / / | '_ \
    # | (_| | (_| | |   \ V  V /| | | | |
    #  \__,_|\__,_|_|    \_/\_/ |_|_| |_|
    #
    mkAlias = {
      url = "github:reckenrode/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #         _
    #  __   _(_)_ __ ___
    #  \ \ / / | '_ ` _ \
    #   \ V /| | | | | | |
    #    \_/ |_|_| |_| |_|
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

    #
    #    ___ _ __ ___   __ _  ___ ___
    #   / _ \ '_ ` _ \ / _` |/ __/ __|
    #  |  __/ | | | | | (_| | (__\__ \
    #   \___|_| |_| |_|\__,_|\___|___/
    emacs.url = "github:cmacrae/emacs";
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    #                    _
    #   _ __   __ _  ___| | ____ _  __ _  ___  ___
    #  | '_ \ / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
    #  | |_) | (_| | (__|   < (_| | (_| |  __/\__ \
    #  | .__/ \__,_|\___|_|\_\__,_|\__, |\___||___/
    #  |_|                         |___/
    jol = {
      url =
        "https://repo.maven.apache.org/maven2/org/openjdk/jol/jol-cli/0.16/jol-cli-0.16-full.jar";
      flake = false;
    };
    tmux-pomodoro-plus = {
      url = "github:olimorris/tmux-pomodoro-plus";
      flake = false;
    };
    fidget-nvim-legacy = {
      url = "github:j-hui/fidget.nvim/legacy";
      flake = false;
    };
    # ddc-vim = {
    #   url = "github:Shougo/ddc.vim/dbaa5703fa8de684def8a5bc5ff50c597702a57c";
    #   flake = false;
    # };
    ddc-sorter_itemsize = {
      url = "github:ttak0422/ddc-sorter_itemsize/feature/support-latest-jdt";
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
