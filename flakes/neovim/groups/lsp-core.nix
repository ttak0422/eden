{ vimPlugins, pkgs, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  name = "lsp";
  plugins = [
    # {
    #   plugin = lsp-timeout-nvim;
    #   # dependPlugins = [ nvim-lspconfig ];
    #   preConfig = readFile ./../../../nvim/lsp-timeout-pre.lua;
    #  postConfig = readFile ./../../../nvim/lsp-timeout.lua;
    # }
    {
      plugin = garbage-day-nvim;
      preConfig = {
        language = "lua";
        code = readFile ./../../../nvim/lua/garbage-day-pre.lua;
      };
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/lua/garbage-day.lua;
      };
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
      ]) ++ (with pkgs.pkgs-unstable; [ nixd marksman ]);
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/lua/lspconfig.lua;
        args = {
          on_attach_path = ./../../../nvim/shared/on_attach.lua;
          capabilities_path = ./../../../nvim/shared/capabilities.lua;
        };
      };
      dependPlugins = [ climbdir-nvim ];
      useTimer = true;
    }
    {
      plugin = lsp-lens-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/lsp-lens.lua;
      };
    }
    {
      plugin = lsp-inlayhints-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/inlayhints.lua;
      };
    }
    # {
    #   # カーソルの対応する要素のハイライト.
    #   plugin = vim-illuminate;
    #  postConfig = readFile ./../../../nvim/illuminate.lua;
    # }
    # {
    #   plugin = hover-nvim;
    #  postConfig = readFile ./../../../nvim/hover.lua;
    # }
    # {
    #   plugin = pretty_hover;
    #  postConfig = readFile ./../../../nvim/pretty-hover.lua;
    # }
    # {
    #   plugin = diagflow-nvim;
    #  postConfig = readFile ./../../../nvim/diagflow.lua;
    # }
    noice-nvim
    # {
    #   plugin = suit-nvim;
    #  postConfig = readFile ./../../../nvim/lua/suit.lua;
    # }
    {
      plugin = dressing-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/lua/dressing.lua;
      };
      dependGroups = [ "telescope" ];
    }
  ];
  dependPlugins = [{
    plugin = fidget-nvim;
    postConfig = {
      language = "lua";
      code = readFile ./../../../nvim/lua/fidget.lua;
    };
  }];
  dependGroups = [ "ddc" ];
  useTimer = true;
}]
