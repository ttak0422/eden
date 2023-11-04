inputs:
with inputs; [
  inputs.neovim-nightly-overlay.overlay
  vim-plugins-overlay.overlay
  nix-filter.overlays.default
  (final: prev:
    let
      inherit (prev.stdenv) mkDerivation isDarwin;
      inherit (prev.stdenv) system;
    in {
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      javaPackages = prev.javaPackages // { inherit (inputs) jol; };
      vimPlugins = prev.vimPlugins // {
        LuaSnip = prev.vimUtils.buildVimPlugin {
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
      };

      python3Packages = prev.python3Packages
        // (with prev.python3Packages; rec {
          wrapt = buildPythonPackage rec {
            pname = "wrapt";
            version = "1.15.0";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-0Gcwxq7XjO5BJiNM8tBx4BtEuRXnJabLQ5qHnsl1Sjo=";
            };
            doCheck = false;
          };
          Deprecated = buildPythonPackage rec {
            pname = "Deprecated";
            version = "1.2.14";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-5TI+uTZFjczCWC3G+cMiyFKndaJwZf8rDElwudU9AbM=";
            };
            doCheck = false;
            propagatedBuildInputs = [ wrapt ];
          };
          jaconv = buildPythonPackage rec {
            pname = "jaconv";
            version = "0.3.4";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-nnxV8/Cw4tutYvbJ+gww/G//27eCl5VVCdkIVrOjHW0=";
            };
            doCheck = false;
          };
          pykakasi = buildPythonPackage rec {
            pname = "pykakasi";
            version = "2.2.1";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-OjUQkppVlsrlH/+pz3jA90LZbOvZP3JslqzuUUB9GMw=";
            };
            doCheck = false;
            propagatedBuildInputs = [ Deprecated jaconv setuptools ];
          };
        });
      sonicCustomTemplates = mkDerivation {
        name = "sonic-custom-templates";
        src = ./../../snippets/sonic;
        installPhase = ''
          mkdir $out
          cp -r ./* $out
        '';
      };

      jdt-language-server = let
        version = "1.28.0";
        timestamp = "202309281329";
      in prev.jdt-language-server.overrideAttrs (old: {
        src = prev.fetchurl {
          url =
            "https://download.eclipse.org/jdtls/milestones/${version}/jdt-language-server-${version}-${timestamp}.tar.gz";
          sha256 =
            "b15c6badd1f437b533d857720d7593c1cbb6ee9afb4dfb0579b7318e3dbb2e19";
        };
      });
      fennel-language-server =
        inputs.fennel-language-server.packages.${system}.default;
      fennel-ls = mkDerivation {
        name = "fennel-ls";
        src = inputs.fennel-ls-src;
        nativeBuildInputs = with prev; [ luajit buildPackages.makeWrapper ];
        buildPhase = ''
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          make install PREFIX=$out
        '';
      };
    })

]
