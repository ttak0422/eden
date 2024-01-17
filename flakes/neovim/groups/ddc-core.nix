{ vimPlugins, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  name = "ddc";
  plugins = [
    {
      plugin = ddc-vim;
      useDenops = true;
    }
    {
      plugin = ddc-ui-pum;
      dependPlugins = [{
        plugin = pum-vim;
        dependPlugins = [
          { plugin = noice-nvim; }
          {
            plugin = nvim-autopairs;
            dependGroups = [ "treesitter" ];
            postConfig = {
              language = "lua";
              code = readFile ./../../../nvim/autopairs.lua;
            };
            onEvents = [ "InsertEnter" ];
            onModules = [ "nvim-autopairs" ];
          }
        ];
        postConfig = {
          language = "vim";
          code = readFile ./../../../nvim/pum.vim;
        };
      }];
      useDenops = true;
    }
    {
      plugin = ddc-buffer;
      useDenops = true;
    }
    {
      plugin = ddc-converter_remove_overlap;
      useDenops = true;
    }
    {
      plugin = ddc-converter_truncate;
      useDenops = true;
    }
    {
      plugin = ddc-fuzzy;
      useDenops = true;
    }
    {
      plugin = ddc-matcher_head;
      useDenops = true;
    }
    {
      plugin = ddc-matcher_length;
      useDenops = true;
    }
    {
      plugin = ddc-sorter_itemsize;
      useDenops = true;
    }
    {
      plugin = ddc-sorter_rank;
      useDenops = true;
    }
    {
      plugin = ddc-source-around;
      useDenops = true;
    }
    {
      plugin = ddc-source-cmdline;
      useDenops = true;
    }
    {
      plugin = ddc-source-cmdline-history;
      useDenops = true;
    }
    {
      plugin = ddc-source-file;
      useDenops = true;
    }
    {
      plugin = ddc-source-input;
      useDenops = true;
    }
    {
      plugin = ddc-source-line;
      useDenops = true;
    }
    {
      plugin = ddc-sorter_reverse;
      useDenops = true;
    }
    {
      plugin = ddc-source-vsnip;
      dependPlugins = [{
        plugin = vim-vsnip;
        dependPlugins = [ tabout-nvim ];
        postConfig = {
          language = "vim";
          code = readFile ./../../../nvim/vsnip.vim;
        };
      }];
      useDenops = true;
    }
    {
      plugin = ddc-source-lsp;
      onModules = [ "ddc_source_lsp" ];
      useDenops = true;
    }
    {
      plugin = ddc-source-lsp-setup;
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/lua/ddc-source-lsp-setup.lua;
      };
      useDenops = true;
    }
    {
      plugin = ddc-tmux;
      useDenops = true;
    }
    # ddc-ui-native
    # denops-popup-preview-vim
    # {
    #   plugin = ddc-previewer-floating;
    #   postConfig = readFile ./../../../nvim/ddc-previewer-floating.lua;
    #   dependPlugins = [ pum-vim ];
    # }
    {
      plugin = denops-signature_help;
      useDenops = true;
    }
    {
      plugin = neco-vim;
      useDenops = true;
    }
    # TODO lazy
    # {
    #   plugin = ddc-source-nvim-obsidian;
    #   dependPlugins = [ obsidian-nvim ];
    #   useDenops = true;
    # }
    {
      plugin = tsnip-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./../../../nvim/tsnip.lua;
        args = { tsnip_root = ./../../../snippets/tsnip; };
      };
      dependPlugins = [ nui-nvim ];
      useDenops = true;
    }
  ];
  dependPlugins = [
    denops-vim
    # {
    #   plugin = LuaSnip;
    #   postConfig = {
    #     language = "lua";
    #     code = readFile ./../../../nvim/luasnip.lua;
    #     args = { snipmate_root = ./../../../snippets/snipmate; };
    #   };
    #   dependPlugins = [ friendly-snippets ];
    # }
  ];
  dependGroups = [ "lsp" "ddu" ];
  postConfig = {
    language = "vim";
    code = readFile ./../../../nvim/ddc.vim;
    args = { ts_config = ./../../../nvim/denops/ddc.ts; };
  };
  onEvents = [ "InsertEnter" "CmdlineEnter" ];
}]
