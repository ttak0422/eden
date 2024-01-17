{ vimPlugins, pkgs, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [
  {
    # Java
    plugin = nvim-jdtls;
    dependPlugins = [ ];
    dependGroups = [ "lsp" ];
    postConfig = let jdtLsp = pkgs.jdt-language-server;
    in {
      language = "lua";
      # code = readFile ./../../../nvim/jdtls.lua;
      code = readFile ./../../../nvim/lua/jdtls.lua;
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
        java_path = "${pkgs.jdk17}/bin/java";
        jdtls_config_path = "${jdtLsp}/share/config";
        lombok_jar_path = "${pkgs.lombok}/share/java/lombok.jar";
        jdtls_jar_pattern =
          "${jdtLsp}/share/java/plugins/org.eclipse.equinox.launcher_*.jar";
        java_debug_jar_pattern =
          "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar";
        java_test_jar_pattern =
          "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar";
        jol_jar_path = pkgs.javaPackages.jol;
      };
    };
    onFiletypes = [ "java" ];
  }
  {
    # JS/TS (node)
    plugin = nvim-vtsls;
    postConfig = {language="lua";code=readFile ./../../../nvim/vtsls.lua;};
    dependGroups = [ "lsp" ];
    onFiletypes = [ "typescript" ];
  }
  {
    # Rust
    plugin = rust-tools-nvim;
    dependPlugins = [ plenary-nvim toggleterm-nvim ];
    dependGroups = [ "lsp" "dap" ];
    postConfig = {
      language = "lua";
      code = readFile ./../../../nvim/rust-tools.lua;
      args = {
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
      };
    };
    onFiletypes = [ "rust" ];
  }
  {
    # Haskell
    plugin = haskell-tools-nvim;
    dependPlugins = [ plenary-nvim ];
    dependGroups = [ "lsp" ];
    extraPackages = with pkgs; [
      haskellPackages.fourmolu
      haskell-language-server
    ];
    postConfig = {
      language = "lua";
      code = readFile ./../../../nvim/haskell-tools.lua;
      args = {
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
      };
    };
    onFiletypes = [ "haskell" ];
  }
  {
    # Flutter
    plugin = flutter-tools-nvim;
    dependPlugins = [ plenary-nvim ];
    dependGroups = [ "lsp" ];
    postConfig = {language="lua";code=readFile ./../../../nvim/flutter-tools.lua;};
    onFiletypes = [ "dart" ];
  }
  {
    # FSharp
    # [WIP] dotnet
    # dotnet tool install -g fsautocomplete
    # dotnet tool install -g dotnet-fsharplint
    # dotnet tool install --global fantomas-tool
    plugin = Ionide-vim;
    dependGroups = [ "lsp" ];
    preConfig = {
      language = "vim";
      code = ''
        let g:fsharp#lsp_auto_setup = 0
        let g:fsharp#fsautocomplete_command =[ 'fsautocomplete' ]
      '';
    };
    postConfig = {
      language = "lua";
      code = readFile ./../../../nvim/ionide.lua;
      args = {
        on_attach_path = ./../../../nvim/shared/on_attach.lua;
        capabilities_path = ./../../../nvim/shared/capabilities.lua;
      };
    };
    onFiletypes = [ "fsharp" ];
  }
  {
    # Fennel
    plugin = nfnl;
    onFiletypes = [ "fennel" ];
    extraPackages = with pkgs; [ sd fd ];
  }
  {
    # markdown
    plugin = mkdnflow-nvim;
    dependPlugins = [ plenary-nvim ];
    onFiletypes = [ "markdown" ];
    postConfig = {language="lua";code=readFile ./../../../nvim/lua/mkdnflow.lua;};
  }
  # {
  #   plugin = nvim-paredit-fennel;
  #   onFiletypes = [ "fennel" ];
  #   dependPlugins = [ nvim-paredit ];
  #  postConfig = readFile ./../../../nvim/lua/paredit-fennel.lua;
  # }
  # {
  #   # closure
  #   plugin = nvim-paredit;
  #   onFiletypes = [ "clojure" ];
  #  postConfig = readFile ./../../../nvim/lua/paredit.lua;
  # }
  # {
  #   plugin = conjure;
  #   prpostConfig = readFile ./../../../nvim/lua/conjure-pre.lua;
  #  postConfig = readFile ./../../../nvim/lua/conjure.lua;
  #   dependPlugins = [{ plugin = aniseed; }];
  #   dependGroups = [ "treesitter" ];
  #   onFiletypes = [ "clojure" "fennel" "scheme" ];
  # }
]
