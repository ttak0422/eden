{ vimPlugins, pkgs, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  name = "lsp";
  plugins = [
    {
      plugin = lsp-timeout-nvim;
      # depends = [ nvim-lspconfig ];
      config = readFile ./../../../nvim/lsp-timeout.lua;
    }
    {
      plugin = nvim-lspconfig;
      # [WIP] dotnet
      # dotnet tool install --global csharp-ls
      extraPackages = (with pkgs; [
        dart
        deno
        dhall-lsp-server
        google-java-format
        gopls
        lua-language-server
        nil
        nodePackages.bash-language-server
        nodePackages.pyright
        nodePackages.typescript
        nodePackages.vscode-langservers-extracted
        nodePackages.yaml-language-server
        rubyPackages.solargraph
        rust-analyzer
        taplo-cli
        # fennel-language-server
        fennel-ls
      ]) ++ (with pkgs.pkgs-unstable; [ nixd ]);
      config = {
        lang = "lua";
        code = readFile ./../../../nvim/lspconfig.lua;
        args = {
          on_attach_path = ./../../../nvim/shared/on_attach.lua;
          capabilities_path = ./../../../nvim/shared/capabilities.lua;
          eslint_cmd = [
            "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-eslint-language-server"
            "--stdio"
          ];
        };
      };
      # depends = [{
      #   plugin = neodev-nvim;
      #   config = readFile ./../../../nvim/neodev.lua;
      # }];
      lazy = true;
    }
    {
      plugin = lsp-lens-nvim;
      config = readFile ./../../../nvim/lsp-lens.lua;
    }
    # {
    #   plugin = actions-preview-nvim;
    #   config = readFile ./../../../nvim/actions-preview.lua;
    #   dependBundles = [ "telescope" ];
    #   modules = [ "actions-preview" ];
    # }
    {
      plugin = lsp-inlayhints-nvim;
      config = readFile ./../../../nvim/inlayhints.lua;
    }
    # {
    #   # カーソルの対応する要素のハイライト.
    #   plugin = vim-illuminate;
    #   config = readFile ./../../../nvim/illuminate.lua;
    # }
    # {
    #   plugin = hover-nvim;
    #   config = readFile ./../../../nvim/hover.lua;
    # }
    # {
    #   plugin = pretty_hover;
    #   config = readFile ./../../../nvim/pretty-hover.lua;
    # }
    # {
    #   plugin = diagflow-nvim;
    #   config = readFile ./../../../nvim/diagflow.lua;
    # }
    noice-nvim
  ];
  depends = [{
    plugin = fidget-nvim;
    config = readFile ./../../../nvim/fidget.lua;
  }];
  dependBundles = [ "ddc" ];
  lazy = true;
}]
