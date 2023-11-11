{ vimPlugins, pkgs, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [
  {
    # Java
    plugin = nvim-jdtls;
    depends = [ ];
    dependBundles = [ "lsp" ];
    config = let jdtLsp = pkgs.jdt-language-server;
    in {
      lang = "lua";
      code = readFile ./../../../nvim/jdtls.lua;
      args = {
        runtimes = [
          {
            name = "JavaSE-11";
            path = pkgs.jdk11;
          }
          {
            name = "JavaSE-17";
            path = pkgs.jdk17;

            default = true;
          }
        ];
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
        java_bin = "${pkgs.jdk17}/bin/java";
        jdtls_config = "${jdtLsp}/share/config";
        lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
        jdtls_jar_pattern =
          "${jdtLsp}/share/java/plugins/org.eclipse.equinox.launcher_*.jar";
        jdtls_settings_path = ./../../../nvim/jdtls_settings.lua;
        java_debug_jar_pattern =
          "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar";
        java_test_jar_pattern =
          "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar";
        jol_jar = pkgs.javaPackages.jol;

      };
    };
    filetypes = [ "java" ];
  }
  {
    # JS/TS (node)
    plugin = nvim-vtsls;
    config = readFile ./../../../nvim/vtsls.lua;
    dependBundles = [ "lsp" ];
    filetypes = [ "typescript" ];
  }
  {
    # Rust
    plugin = rust-tools-nvim;
    depends = [ plenary-nvim toggleterm-nvim ];
    dependBundles = [ "lsp" "dap" ];
    config = {
      lang = "lua";
      code = readFile ./../../../nvim/rust-tools.lua;
      args = {
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
      };
    };
    filetypes = [ "rust" ];
  }
  {
    # Haskell
    plugin = haskell-tools-nvim;
    depends = [ plenary-nvim ];
    dependBundles = [ "lsp" ];
    extraPackages = with pkgs; [
      haskellPackages.fourmolu
      haskell-language-server
    ];
    config = {
      lang = "lua";
      code = readFile ./../../../nvim/haskell-tools.lua;
      args = {
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
      };
    };
    filetypes = [ "haskell" ];
  }
  {
    # Flutter
    plugin = flutter-tools-nvim;
    depends = [ plenary-nvim ];
    dependBundles = [ "lsp" ];
    config = readFile ./../../../nvim/flutter-tools.lua;
    filetypes = [ "dart" ];
  }
  {
    # FSharp
    # [WIP] dotnet
    # dotnet tool install -g fsautocomplete
    # dotnet tool install -g dotnet-fsharplint
    # dotnet tool install --global fantomas-tool
    plugin = Ionide-vim;
    dependBundles = [ "lsp" ];
    preConfig = {
      lang = "vim";
      code = ''
        let g:fsharp#lsp_auto_setup = 0
        let g:fsharp#fsautocomplete_command =[ 'fsautocomplete' ]
      '';
    };
    config = {
      lang = "lua";
      code = readFile ./../../../nvim/ionide.lua;
      args = {
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
      };
    };
    filetypes = [ "fsharp" ];
  }
  {
    # Fennel
    plugin = nfnl;
    filetypes = [ "fennel" ];
    extraPackages = with pkgs; [ fnlfmt sd fd ];
  }
  {
    plugin = conjure;
    preConfig = readFile ./../../../nvim/lua/conjure-pre.lua;
    config = readFile ./../../../nvim/lua/conjure.lua;
    depends = [{ plugin = aniseed; }];
    dependBundles = [ "treesitter" ];
    filetypes = [ "clojure" "fennel" "scheme" ];
  }
]
