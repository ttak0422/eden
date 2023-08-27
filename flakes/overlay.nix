{ inputs, lib, ... }: {
  flake.overlays = {
    fromInputs = lib.composeManyExtensions [
      # WIP: darwin
      # inputs.neovim-nightly-overlay.overlay
      inputs.vim-plugins-overlay.overlay
      inputs.emacs.overlay
      inputs.nix-filter.overlays.default
      (final: prev:
        let inherit (prev.stdenv) mkDerivation isDarwin;
        in {
          vimPlugins = prev.vimPlugins // {
            LuaSnip = prev.vimUtils.buildVimPluginFrom2Nix {
              pname = "LuaSnip";
              version = "unstable";
              src = prev.vimPlugins.LuaSnip;
              nativeBuildInputs = [ prev.gcc ];
              buildPhase = ''
                ${if isDarwin then
                  "LUA_LDLIBS='-undefined dynamic_lookup -all_load'"
                else
                  ""}
                JSREGEXP_PATH=deps/jsregexp
                make "INCLUDE_DIR=-I $PWD/deps/lua51_include" LDLIBS="$LUA_LDLIBS" -C $JSREGEXP_PATH

                cp $JSREGEXP_PATH/jsregexp.so lua/luasnip-jsregexp.so
              '';
            };
            fidget-nvim = prev.vimPlugins.fidget-nvim.overrideAttrs (old: {
              version = "custom";
              src = inputs.fidget-nvim-legacy;
            });
            # piccolo-pomodoro-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
            #   pname = "piccolo-pomodoro-nvim";
            #   version = "local";
            #   src = inputs.piccolo-pomodoro-nvim;
            # };
            # ddc-sorter_reverse = prev.vimUtils.buildVimPluginFrom2Nix {
            #   pname = "ddc-sorter_reverse";
            #   version = "local";
            #   src = inputs.ddc-sorter_reverse;
            # };
            # ddc-vim = prev.vimUtils.buildVimPluginFrom2Nix {
            #   pname = "ddc-vim";
            #   version = "local";
            #   src = inputs.ddc-vim;
            # };
          };
          tmuxPlugins = prev.tmuxPlugins // {
            # tmux-pomodoro-plus = prev.tmuxPlugins.mkTmuxPlugin {
            #   pluginName = "tmux-pomodoro-plus";
            #   rtpFilePath = "pomodoro.tmux";
            #   version = "local";
            #   src = inputs.tmux-pomodoro-plus;
            # };
          };
          javaPackages = prev.javaPackages // { inherit (inputs) jol; };
          python3Packages = prev.python3Packages
            // (with prev.python3Packages; rec {
              wrapt = buildPythonPackage rec {
                pname = "wrapt";
                version = "1.15.0";
                src = prev.fetchPypi {
                  inherit pname version;
                  sha256 =
                    "sha256-0Gcwxq7XjO5BJiNM8tBx4BtEuRXnJabLQ5qHnsl1Sjo=";
                };
                doCheck = false;
              };
              Deprecated = buildPythonPackage rec {
                pname = "Deprecated";
                version = "1.2.14";
                src = prev.fetchPypi {
                  inherit pname version;
                  sha256 =
                    "sha256-5TI+uTZFjczCWC3G+cMiyFKndaJwZf8rDElwudU9AbM=";
                };
                doCheck = false;
                propagatedBuildInputs = [ wrapt ];
              };
              jaconv = buildPythonPackage rec {
                pname = "jaconv";
                version = "0.3.4";
                src = prev.fetchPypi {
                  inherit pname version;
                  sha256 =
                    "sha256-nnxV8/Cw4tutYvbJ+gww/G//27eCl5VVCdkIVrOjHW0=";
                };
                doCheck = false;
              };
              pykakasi = buildPythonPackage rec {
                pname = "pykakasi";
                version = "2.2.1";
                src = prev.fetchPypi {
                  inherit pname version;
                  sha256 =
                    "sha256-OjUQkppVlsrlH/+pz3jA90LZbOvZP3JslqzuUUB9GMw=";
                };
                doCheck = false;
                propagatedBuildInputs = [ Deprecated jaconv setuptools ];
              };
            });
          sonicCustomTemplates = mkDerivation {
            name = "sonic-custom-templates";
            src = ./../snippets/sonic;
            installPhase = ''
              mkdir $out
              cp -r ./* $out
            '';
          };
          jdt-language-server = let
            version = "1.26.0";
            timestamp = "202307271613";
          in prev.jdt-language-server.overrideAttrs (old: {
            src = prev.fetchurl {
              url =
                "https://download.eclipse.org/jdtls/milestones/${version}/jdt-language-server-${version}-${timestamp}.tar.gz";
              sha256 =
                "ba5fe5ee3b2a8395287e24aef20ce6e17834cf8e877117e6caacac6a688a6c53";
            };
          });

          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            config.allowUnfree = true;
          };
          pkgs-x86_64-darwin = import inputs.nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
        })
    ];
  };
}
