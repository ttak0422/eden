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
      depends = [{
        plugin = pum-vim;
        depends = [
          { plugin = noice-nvim; }
          {
            plugin = nvim-autopairs;
            dependBundles = [ "treesitter" ];
            config = readFile ./../../../nvim/autopairs.lua;
            events = [ "InsertEnter" ];
            modules = [ "nvim-autopairs" ];
          }
        ];
        config = {
          lang = "vim";
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
      depends = [{
        plugin = vim-vsnip;
        depends = [ tabout-nvim ];
        config = {
          lang = "vim";
          code = readFile ./../../../nvim/vsnip.vim;
        };
      }];
      useDenops = true;
    }
    {
      plugin = ddc-source-nvim-lsp;
      modules = [ "ddc_nvim_lsp" ];
      useDenops = true;
    }
    {
      plugin = ddc-nvim-lsp-setup;
      config = readFile ./../../../nvim/ddc-nvim-lsp-setup.lua;
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
    #   config = readFile ./../../../nvim/ddc-previewer-floating.lua;
    #   depends = [ pum-vim ];
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
    {
      plugin = ddc-source-nvim-obsidian;
      depends = [ obsidian-nvim ];
      useDenops = true;
    }
    {
      plugin = tsnip-nvim;
      config = {
        lang = "lua";
        code = readFile ./../../../nvim/tsnip.lua;
        args = { tsnip_root = ./../../../snippets/tsnip; };
      };
      depends = [ nui-nvim ];
      useDenops = true;
    }
  ];
  depends = [
    denops-vim
    # {
    #   plugin = LuaSnip;
    #   config = {
    #     lang = "lua";
    #     code = readFile ./../../../nvim/luasnip.lua;
    #     args = { snipmate_root = ./../../../snippets/snipmate; };
    #   };
    #   depends = [ friendly-snippets ];
    # }
  ];
  dependBundles = [ "lsp" ];
  config = {
    lang = "vim";
    code = readFile ./../../../nvim/ddc.vim;
    args = { ts_config = ./../../../nvim/ddc.ts; };
  };
  events = [ "InsertEnter" "CmdlineEnter" ];
}]
