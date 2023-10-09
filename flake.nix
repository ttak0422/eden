{
  description = "eden";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

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
    oboro-nvim2 = {
      url = "path:/Users/ttak0422/ghq/github.com/ttak0422/oboro-nvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        nix-filter.follows = "nix-filter";
      };
    };
    bundler = {
      url = "path:/Users/ttak0422/ghq/github.com/ttak0422/bundler";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    bundler-test = {
      url = "path:/Users/ttak0422/ghq/github.com/srid/emanote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # flake-utils.follows = "flake-utils";
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
    fidget-nvim-legacy = {
      url = "github:j-hui/fidget.nvim/legacy";
      flake = false;
    };
    # ddc-vim = {
    #   url = "github:Shougo/ddc.vim/dbaa5703fa8de684def8a5bc5ff50c597702a57c";
    #   flake = false;
    # };
    # piccolo-pomodoro-nvim = {
    #   url = "path:/Users/ttak0422/ghq/github.com/ttak0422/piccolo-pomodoro.nvim";
    #   flake = false;
    # };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      imports = [
        ./flakes
        ./libs
        ./modules
        # inputs.bundler.flakeModules.nvim
      ];
      # perSystem = { system, config, pkgs, ... }: {
      #   _module.args.pkgs = import inputs.nixpkgs {
      #     inherit system;
      #     overlays = with inputs; [
      #       # WIP: darwin
      #       # inputs.neovim-nightly-overlay.overlay
      #       inputs.vim-plugins-overlay.overlay
      #       inputs.emacs.overlay
      #       inputs.nix-filter.overlays.default
      #       (final: prev:
      #         let inherit (prev.stdenv) mkDerivation isDarwin;
      #         in {
      #           vimPlugins = prev.vimPlugins // {
      #             LuaSnip = prev.vimUtils.buildVimPluginFrom2Nix {
      #               pname = "LuaSnip";
      #               version = "unstable";
      #               src = prev.vimPlugins.LuaSnip;
      #               nativeBuildInputs = [ prev.gcc ];
      #               buildPhase = ''
      #                 ${if isDarwin then
      #                   "LUA_LDLIBS='-undefined dynamic_lookup -all_load'"
      #                 else
      #                   ""}
      #                 JSREGEXP_PATH=deps/jsregexp
      #                 make "INCLUDE_DIR=-I $PWD/deps/lua51_include" LDLIBS="$LUA_LDLIBS" -C $JSREGEXP_PATH
      #
      #                 cp $JSREGEXP_PATH/jsregexp.so lua/luasnip-jsregexp.so
      #               '';
      #             };
      #             fidget-nvim = prev.vimPlugins.fidget-nvim.overrideAttrs (old: {
      #               version = "custom";
      #               src = inputs.fidget-nvim-legacy;
      #             });
      #             # piccolo-pomodoro-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
      #             #   pname = "piccolo-pomodoro-nvim";
      #             #   version = "local";
      #             #   src = inputs.piccolo-pomodoro-nvim;
      #             # };
      #             # ddc-sorter_reverse = prev.vimUtils.buildVimPluginFrom2Nix {
      #             #   pname = "ddc-sorter_reverse";
      #             #   version = "local";
      #             #   src = inputs.ddc-sorter_reverse;
      #             # };
      #             # ddc-vim = prev.vimUtils.buildVimPluginFrom2Nix {
      #             #   pname = "ddc-vim";
      #             #   version = "local";
      #             #   src = inputs.ddc-vim;
      #             # };
      #           };
      #           tmuxPlugins = prev.tmuxPlugins // {
      #             # tmux-pomodoro-plus = prev.tmuxPlugins.mkTmuxPlugin {
      #             #   pluginName = "tmux-pomodoro-plus";
      #             #   rtpFilePath = "pomodoro.tmux";
      #             #   version = "local";
      #             #   src = inputs.tmux-pomodoro-plus;
      #             # };
      #           };
      #           javaPackages = prev.javaPackages // { inherit (inputs) jol; };
      #           python3Packages = prev.python3Packages
      #             // (with prev.python3Packages; rec {
      #               wrapt = buildPythonPackage rec {
      #                 pname = "wrapt";
      #                 version = "1.15.0";
      #                 src = prev.fetchPypi {
      #                   inherit pname version;
      #                   sha256 =
      #                     "sha256-0Gcwxq7XjO5BJiNM8tBx4BtEuRXnJabLQ5qHnsl1Sjo=";
      #                 };
      #                 doCheck = false;
      #               };
      #               Deprecated = buildPythonPackage rec {
      #                 pname = "Deprecated";
      #                 version = "1.2.14";
      #                 src = prev.fetchPypi {
      #                   inherit pname version;
      #                   sha256 =
      #                     "sha256-5TI+uTZFjczCWC3G+cMiyFKndaJwZf8rDElwudU9AbM=";
      #                 };
      #                 doCheck = false;
      #                 propagatedBuildInputs = [ wrapt ];
      #               };
      #               jaconv = buildPythonPackage rec {
      #                 pname = "jaconv";
      #                 version = "0.3.4";
      #                 src = prev.fetchPypi {
      #                   inherit pname version;
      #                   sha256 =
      #                     "sha256-nnxV8/Cw4tutYvbJ+gww/G//27eCl5VVCdkIVrOjHW0=";
      #                 };
      #                 doCheck = false;
      #               };
      #               pykakasi = buildPythonPackage rec {
      #                 pname = "pykakasi";
      #                 version = "2.2.1";
      #                 src = prev.fetchPypi {
      #                   inherit pname version;
      #                   sha256 =
      #                     "sha256-OjUQkppVlsrlH/+pz3jA90LZbOvZP3JslqzuUUB9GMw=";
      #                 };
      #                 doCheck = false;
      #                 propagatedBuildInputs = [ Deprecated jaconv setuptools ];
      #               };
      #             });
      #           sonicCustomTemplates = mkDerivation {
      #             name = "sonic-custom-templates";
      #             src = ./../snippets/sonic;
      #             installPhase = ''
      #               mkdir $out
      #               cp -r ./* $out
      #             '';
      #           };
      #           jdt-language-server = let
      #             version = "1.28.0";
      #             timestamp = "202309281329";
      #           in prev.jdt-language-server.overrideAttrs (old: {
      #             src = prev.fetchurl {
      #               url =
      #                 "https://download.eclipse.org/jdtls/milestones/${version}/jdt-language-server-${version}-${timestamp}.tar.gz";
      #               sha256 =
      #                 "b15c6badd1f437b533d857720d7593c1cbb6ee9afb4dfb0579b7318e3dbb2e19";
      #             };
      #           });
      #
      #           pkgs-unstable = import inputs.nixpkgs-unstable {
      #             inherit (prev.stdenv) system;
      #             config.allowUnfree = true;
      #           };
      #           pkgs-x86_64-darwin = import inputs.nixpkgs {
      #             system = "x86_64-darwin";
      #             config.allowUnfree = true;
      #           };
      #         })
      #
      #     ];
      #   };
      # };

      # perSystem = { system, config, pkgs, ... }: {
      #   # bundler-nvim.nvim-default = {
      #   #   enable = true;
      #   #   # startPlugins = with pkgs.vimPlugins; [ vim-sensible ];
      #   #   # extraConfig = ''
      #   #   #   " test
      #   #   # '';
      #   # };
      #   # bundler-nvim.default2 = {
      #   #   enable = true;
      #   # package = inputs.nifoc-overlay.packages.${system}.neovim-nightly;
      #   #   startPlugins = with pkgs.vimPlugins; [ kanagawa-nvim ];
      #   #   extraConfig = ''
      #   #     " test
      #   #   '';
      #   # };
      # };
    };
}
