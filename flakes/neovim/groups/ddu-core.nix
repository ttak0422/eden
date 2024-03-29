{ vimPlugins, pkgs, ... }:
let inherit (builtins) readFile;
in with vimPlugins; [{
  name = "ddu";
  plugins = [
    {
      plugin = ddu-vim;
      useDenops = true;
    }
    # ui
    {
      plugin = ddu-ui-ff;
      useDenops = true;
    }
    {
      plugin = ddu-ui-filer;
      useDenops = true;
    }
    # source
    {
      plugin = ddu-source-file;
      useDenops = true;
    }
    {
      plugin = ddu-source-file_rec;
      useDenops = true;
    }
    {
      plugin = ddu-source-rg;
      preConfig = {
        language = "vim";
        code = ''
          let g:loaded_ddu_rg = 1
        '';
      };
      useDenops = true;
      extraPackages = with pkgs; [ ripgrep ];
    }
    {
      plugin = ddu-source-ghq;
      useDenops = true;
      extraPackages = with pkgs; [ ghq ];
    }
    {
      plugin = ddu-source-file_external;
      useDenops = true;
      extraPackages = with pkgs; [ fd ];
    }
    {
      plugin = ddu-source-mr;
      useDenops = true;
      dependPlugins = [ mr-vim ];
    }
    # filter
    {
      plugin = ddu-filter-fzf;
      useDenops = true;
      extraPackages = with pkgs; [ fzf ];
    }
    {
      plugin = ddu-filter-matcher_files;
      useDenops = true;
    }
    # filter (matcher)
    {
      plugin = ddu-filter-matcher_substring;
      useDenops = true;
    }
    {
      plugin = ddu-filter-matcher_hidden;
      useDenops = true;
    }
    # filter (sorter)
    {
      plugin = ddu-filter-sorter_alpha;
      useDenops = true;
    }
    # filter (converter)
    {
      plugin = ddu-filter-converter_hl_dir;
      useDenops = true;
    }
    {
      plugin = ddu-filter-converter_devicon;
      useDenops = true;
    }
    {
      plugin = ddu-filter-converter_display_word;
      useDenops = true;
    }
    # kind
    {
      plugin = ddu-kind-file;
      useDenops = true;
    }
    # other
    {
      plugin = ddu-commands-vim;
      useDenops = true;
    }
    {
      plugin = kensaku-vim;
      useDenops = true;
    }
    # {
    #   plugin = ddu-vim-ui-select;
    #   useDenops = true;
    # }
  ];
  dependPlugins = [ denops-vim qf-nvim nvim-bqf ];
  postConfig = {
    language = "vim";
    code = readFile ./../../../nvim/ddu.vim;
    args = { ts_config = ./../../../nvim/denops/ddu.ts; };
  };
  onCommands = [ "Ddu" "DduRg" "DduRgLive" ];
  useTimer = true;
}]
