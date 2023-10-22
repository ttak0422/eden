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
    # filter
    {
      plugin = ddu-filter-fzf;
      useDenops = true;
      extraPackages = with pkgs; [ fzf ];
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
  ];
  depends = [ denops-vim ];
  config = {
    lang = "vim";
    code = readFile ./../../nvim/ddu.vim;
    args = { ts_config = ./../../nvim/ddu.ts; };
  };
  # commands = [ "Ddu" ];
  commands = [ "Ddu" ];
  lazy = true;
}]
