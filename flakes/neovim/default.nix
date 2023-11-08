{ inputs, ... }: {
  imports = [ inputs.bundler.flakeModules.nvim ];
  perSystem = { system, config, pkgs, lib, ... }:
    let
      inherit (builtins) readFile;
      inherit (pkgs) callPackage;
      inherit (lib) flatten;
      inherit (lib.strings) concatStringsSep;
    in {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./overlays.nix inputs;
      };
      bundler-nvim = {
        default = {
          package = pkgs.neovim-nightly;
          # logLevel = "debug";
          extraConfig = ''
            ${readFile ./../../nvim/disable-default-plugin.vim}
            ${readFile ./../../nvim/prelude.vim}
            ${readFile ./../../nvim/keymap.vim}
          '';
          extraLuaConfig = ''
            vim.loader.enable()
            dofile("${./../../nvim/lua/prelude.lua}")
            ${readFile ./../../nvim/keymap.lua}
            if vim.g.neovide then
              dofile("${./../../nvim/neovide.lua}")
            end
          '';
          startPlugins = callPackage ./plugins/startup.nix { };
          optPlugins = with pkgs.vimPlugins;
            [
              {
                plugin = wf-nvim;
                config = readFile ./../../nvim/lua/wf.lua;
                depends = [ nvim-web-devicons ];
                modules = [ "wf.builtin.which_key" ];
                lazy = true;
              }
              # {
              #   plugin = auto-indent-nvim;
              #   config = readFile ./../../nvim/lua/autoindent.lua;
              #   events = [ "InsertEnter" ];
              #   dependBundles = [ "treesitter" ];
              # }
              {
                plugin = winshift-nvim;
                commands = [ "WinShift" ];

              }
              {
                plugin = vim-startuptime;
                commands = [ "StartupTime" ];
              }
              # {
              #   # 画像のプレビュー
              #   plugin = chafa-nvim;
              #   config = readFile ./../../nvim/chafa.lua;
              #   depends = [ plenary-nvim baleia-nvim ];
              #   extraPackages = with pkgs; [ chafa ];
              #   commands = [ "ViewImage" ];
              # }
              {
                plugin = pkgs.pkgs-unstable.vimPlugins.markdown-preview-nvim;
                filetypes = [ "markdown" ];
              }
              {
                plugin = kensaku-command-vim;
                depends = [{
                  plugin = kensaku-vim;
                  useDenops = true;
                  depends = [ denops-vim ];
                }];
                commands = [ "Kensaku" ];
              }
              { plugin = nano-theme-nvim; }
              {
                plugin = harpoon;
                config = readFile ./../../nvim/harpoon.lua;
                depends = [ plenary-nvim ];
                modules = [ "harpoon.mark" "harpoon.ui" ];
              }
              {
                plugin = copilot-lua;
                config = readFile ./../../nvim/copilot.lua;
                lazy = true;
              }
              {
                plugin = nap-nvim;
                config = readFile ./../../nvim/nap.lua;
                depends = [{
                  plugin = vim-bufsurf;
                  config = readFile ./../../nvim/bufsurf.lua;
                }];
                events = [ "CursorMoved" ];
              }
              {
                plugin = reacher-nvim;
                config = readFile ./../../nvim/reacher.lua;
                modules = [ "reacher" ];
              }
              {
                plugin = nvim-window;
                config = readFile ./../../nvim/nvim-window.lua;
                modules = [ "nvim-window" ];
              }
              {
                plugin = JABS-nvim;
                config = readFile ./../../nvim/JABS.lua;
                commands = [ "JABSOpen" ];
              }
              {
                plugin = leap-nvim;
                depends = [ vim-repeat ];
                config = readFile ./../../nvim/leap.lua;
                events = [ "CursorMoved" ];
              }
              {
                plugin = flit-nvim;
                config = readFile ./../../nvim/flit.lua;
                events = [ "CursorMoved" ];
              }
              {
                plugin = tabout-nvim;
                config = readFile ./../../nvim/tabout.lua;
                dependBundles = [ "treesitter" ];
                events = [ "InsertEnter" ];
              }
              {
                plugin = nvim-dap-go;
                config = readFile ./../../nvim/dap-go.lua;
                dependBundles = [ "dap" ];
                filetypes = [ "go" ];
                extraPackages = with pkgs; [ delve ];
              }
              {
                plugin = nvim-colorizer-lua;
                config = readFile ./../../nvim/colorizer.lua;
                commands = [ "ColorizerToggle" ];
              }
              {
                # タスクランナー
                plugin = overseer-nvim;
                depends = [ toggleterm-nvim ];
                config = readFile ./../../nvim/overseer.lua;
                commands = [ "OverseerRun" ];
              }
              {
                plugin = project-nvim;
                config = readFile ./../../nvim/project.lua;
                lazy = true;
              }
              { plugin = vim-jukit; }
              {
                plugin = codewindow-nvim;
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/codewindow.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                  };
                };
                dependBundles = [ "treesitter" ];
                events = [ "CursorHold" ];
                modules = [ "codewindow" ];
              }
              {
                # require ts-parser norg.nvim
                plugin = neorg;
                depends = [
                  plenary-nvim
                  {
                    plugin = headlines-nvim;
                    dependBundles = [ "treesitter" ];
                    config = readFile ./../../nvim/headlines.lua;
                  }
                ];
                dependBundles = [ "treesitter" ];
                # startup = {
                #   lang = "vim";
                #   code = readFile "${neorg}/ftdetect/norg./../../nvimvim";
                # };
                config = readFile ./../../nvim/neorg.lua;
                commands = [ "Neorg" ];
                # filetypes = [ "norg" ];
              }
              {
                plugin = toggleterm-nvim;
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/toggleterm.lua;
                };
                commands = [ "TermToggle" "TigTermToggle" ];
              }
              {
                plugin = nvim-FeMaco-lua;
                dependBundles = [ "treesitter" ];
                config = readFile ./../../nvim/femaco.lua;
                commands = [ "FeMaco" ];
              }
              {
                plugin = smart-splits-nvim;
                config = readFile ./../../nvim/smart-splits.lua;
                depends = [{
                  plugin = bufresize-nvim;
                  config = readFile ./../../nvim/bufresize.lua;
                  events = [ "WinNew" ];
                }];
                modules = [ "smart-splits" ];
              }
              {
                plugin = NeoZoom-lua;
                config = readFile ./../../nvim/neo-zoom.lua;
                commands = [ "NeoZoomToggle" ];
              }
              # {
              #   plugin = vim-fontzoom;
              #   preConfig = readFile ./../../nvim/fontzoom-pre.lua;
              #   commands = [ "Fontzoom" ];
              # }
              # {
              #   plugin = hologram-nvim;
              #   config = readFile ./../../nvim/hologram.lua;
              #   filetypes = [ "markdown" ];
              # }
              {
                plugin = pets-nvim;
                depends = [ hologram-nvim nui-nvim ];
                config = readFile ./../../nvim/pets.lua;
                commands = [ "PetsNew" ];
              }
              {
                # regex search panel.nvim
                plugin = nvim-spectre;
                depends = [ plenary-nvim nvim-web-devicons ];
                config = readFile ./../../nvim/spectre.lua;
                extraPackages = with pkgs; [ gnused ripgrep ];
                modules = [ "spectre" ];
              }
              {
                plugin = registers-nvim;
                config = readFile ./../../nvim/registers.lua;
                events = [ "CursorMoved" ];
              }
              {
                plugin = nvim-bufdel;
                config = readFile ./../../nvim/bufdel.lua;
                commands = [ "BufDel" "BufDel!" "BufDelAll" "BufDelOthers" ];
              }
              # {
              #   plugin = close-buffers-nvim;
              #   config = readFile ./../../nvim/close-buffer.lua;
              #   modules = [ "close_buffers" ];
              #   commands = [ "BDelete" "BDelete!" ];
              # }
              {
                plugin = nvim-tree-lua;
                depends = [ nvim-web-devicons circles-nvim ];
                config = readFile ./../../nvim/nvim-tree.lua;
                commands = [ "NvimTreeToggle" ];
              }
              {
                plugin = neotree-nvim-3;
                depends = [ plenary-nvim nvim-web-devicons nui-nvim ];
                config = readFile ./../../nvim/neotree.lua;
                commands = [ "Neotree" ];
              }
              {
                plugin = nvim-window-picker;
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/window-picker.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                    exclude_buf_ft_path =
                      ./../../nvim/shared/exclude_buf_ft.lua;
                  };
                };
                modules = [ "window-picker" ];
              }
              {
                plugin = obsidian-nvim;
                depends = [ plenary-nvim ];
                config = readFile ./../../nvim/obsidian.lua + ''
                  vim.cmd([[silent source ${obsidian-nvim}/after/syntax/markdown.vim]])
                '';
                commands = [
                  "ObsidianBacklinks"
                  "ObsidianToday"
                  "ObsidianYesterday"
                  "ObsidianOpen"
                  "ObsidianNew"
                  "ObsidianSearch"
                  "ObsidianQuickSwitch"
                  "ObsidianLink"
                  "ObsidianLinkNew"
                  "ObsidianFollowLink"
                ];
              }
              {
                plugin = sidebar-nvim;
                config = readFile ./../../nvim/sidebar.lua;
                commands = [ "SidebarNvimToggle" ];
              }
              {
                plugin = nvim-web-devicons;
                config = readFile ./../../nvim/devicons.lua;
              }
              # {
              #   # モードに応じたカーソルカラーを適用する
              #   plugin = modes-nvim;
              #   config = {
              #     lang = "lua";
              #     code = readFile ./../../nvim/modes.lua;
              #     args = { exclude_ft_path = ./../../nvim/shared/exclude_ft.lua; };
              #   };
              #   lazy = true;
              # }
              {
                plugin = tint-nvim;
                config = readFile ./../../nvim/tint.lua;
                events = [ "WinNew" ];
              }
              # {
              #   plugin = windows-nvim;
              #   depends = [ middleclass animation-nvim ];
              #   config = {
              #     lang = "lua";
              #     code = readFile ./../../nvim/windows.lua;
              #     args = { exclude_ft_path = ./../../nvim/shared/exclude_ft.lua; };
              #   };
              #   events = [ "WinNew" ];
              # }
              # {
              #   plugin = nvim-treesitter-context;
              #   dependBundles = [ "treesitter" ];
              #   config = readFile ./../../nvim/treesitter-context.lua;
              #   events = [ "CursorMoved" ];
              # }
              {
                plugin = nvim-notify;
                config = readFile ./../../nvim/notify.lua;
                lazy = true;
              }
              {
                plugin = dropbar-nvim;
                config = readFile ./../../nvim/dropbar.lua;
                depends = [ nvim-web-devicons ];
                lazy = true;
              }
              # {
              #   plugin = windline-nvim;
              #   config = readFile ./../../nvim/windline.lua;
              #   lazy = true;
              # }
              {
                plugin = heirline-nvim;
                config = readFile ./../../nvim/heirline.lua;
                depends = [
                  plenary-nvim
                  nvim-web-devicons
                  {
                    plugin = piccolo-pomodoro-nvim;
                    config = readFile ./../../nvim/piccolo-pomodoro.lua;
                    modules = [ "piccolo-pomodoro" ];
                  }
                  hydra-nvim
                ];
                dependBundles = [ "skk" ];
                lazy = true;
              }
              # {
              #   plugin = nvim-scrollbar;
              #   depends = [ gitsigns-nvim ];
              #   config = {
              #     lang = "lua";
              #     code = readFile ./../../nvim/scrollbar.lua;
              #     args = {
              #       exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
              #       exclude_buf_ft_path = ./../../nvim/shared/exclude_buf_ft.lua;
              #     };
              #   };
              #   events = [ "CursorMoved" ];
              # }
              {
                plugin = satellite-nvim;
                depends = [ gitsigns-nvim ];
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/satellite.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                  };
                };
                events = [ "CursorMoved" ];
              }
              {
                plugin = colorful-winsep-nvim;
                events = [ "WinNew" ];
                config = readFile ./../../nvim/winsep.lua;
              }
              {
                plugin = scope-nvim;
                config = readFile ./../../nvim/scope.lua;
              }
              {
                plugin = bufferline-nvim;
                depends = [ scope-nvim ];
                config = readFile ./../../nvim/bufferline.lua;
                lazy = true;
              }
              {
                plugin = vim-nix;
                filetypes = [ "nix" ];
              }
              {
                plugin = vim-markdown;
                preConfig = readFile ./../../nvim/vim-markdown-pre.lua;
                filetypes = [ "markdown" ];
              }
              # {
              #   plugin = neofsharp-vim;
              #   filetypes = [ "fs" "fsx" "fsi" "fsproj" ];
              # }
              {
                plugin = git-conflict-nvim;
                config = readFile ./../../nvim/git-conflict.lua;
                lazy = true;
              }
              {
                plugin = gitsigns-nvim;
                depends = [ plenary-nvim ];
                config = readFile ./../../nvim/gitsign.lua;
                events = [ "CursorMoved" ];
              }
              {
                plugin = gina-vim;
                config = {
                  lang = "vim";
                  code = readFile ./../../nvim/gina.vim;
                };
                commands = [ "Gina" ];
              }
              {
                plugin = gin-vim;
                config = readFile ./../../nvim/gin.lua;
                depends = [ denops-vim ];
                commands = [
                  "Gin"
                  "GinBuffer"
                  "GinLog"
                  "GinStatus"
                  "GinDiff"
                  "GinBrowse"
                  "GinBranch"
                ];
                useDenops = true;
              }
              {
                plugin = neogit;
                depends = [ diffview-nvim plenary-nvim ];
                config = readFile ./../../nvim/neogit.lua;
                commands = [ "Neogit" ];
              }
              {
                plugin = diffview-nvim;
                depends = [ plenary-nvim ];
                commands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
              }
              # {
              #   plugin = vim-typo;
              #   events = [ "BufEnter" ];
              # }
              {
                plugin = treesj;
                config = readFile ./../../nvim/treesj.lua;
                modules = [ "treesj" ];
              }
              {
                plugin = neogen;
                dependBundles = [ "treesitter" ];
                config = readFile ./../../nvim/neogen.lua;
                commands = [ "Neogen" ];
              }
              {
                plugin = glance-nvim;
                config = readFile ./../../nvim/glance.lua;
                commands = [ "Glance" ];
              }
              {
                plugin = goto-preview;
                depends = [ tint-nvim ];
                config = readFile ./../../nvim/goto-preview.lua;
                modules = [ "goto-preview" ];
              }
              {
                plugin = legendary-nvim;
                dependBundles = [ "telescope" ];
                config = readFile ./../../nvim/legendary.lua;
                commands = [ "Legendary" ];
              }
              {
                # ys, ds, cs, ...
                plugin = nvim-surround;
                config = readFile ./../../nvim/surround.lua;
                events = [ "InsertEnter" ];
              }
              {
                plugin = nvim-ts-autotag;
                dependBundles = [ "treesitter" ];
                config = readFile ./../../nvim/ts-autotag.lua;
                filetypes =
                  [ "javascript" "typescript" "jsx" "tsx" "vue" "html" ];
              }
              {
                plugin = todo-comments-nvim;
                depends = [ plenary-nvim trouble-nvim ];
                config = readFile ./../../nvim/todo-comments.lua;
                commands = [
                  "TodoQuickFix"
                  "TodoLocList"
                  "TodoTrouble"
                  "TodoTelescope"
                ];
                extraPackages = [ pkgs.ripgrep ];
                lazy = true;
              }
              {
                plugin = trouble-nvim;
                config = readFile ./../../nvim/trouble.lua;
                modules = [ "trouble" ];
                commands = [ "TroubleToggle" ];
              }
              # {
              #   plugin = spaceless-nvim;
              #   config = readFile ./../../nvim/spaceless.lua;
              #   lazy = true;
              # }
              {
                plugin = trim-nvim;
                config = readFile ./../../nvim/trim.lua;
                lazy = true;
              }
              {
                plugin = nvim_context_vt;
                dependBundles = [ "treesitter" ];
                config = readFile ./../../nvim/context-vt.lua;
                lazy = true;
              }
              # {
              #   plugin = nvim-treesitter';
              #   config = let
              #     nvim-plugintree = (pkgs.imPlugins.nvim-treesitter.withPlugins
              #       (p: [ p.nvimc p.lua p.nix p.bash p.cpp p.json p.python p.markdown ]));
              #     treesitter-parsers = pkgs.nvimsymlinkJoin {
              #       name = "treesitter-parsers";
              #       paths = nvim-plugintree.dependencies;
              #     };
              #   in ''
              #     vim.opt.runtimepath:append("${treesitter-parsers}");
              #   '' + readFile ./../../nvim/treesitter.lua;
              #   extraPackages = [ pkgs.tree-sitter ];
              # }
              {
                plugin = nvim-lint;
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/lint.lua;
                  args = {
                    checkstyle_config_file_path =
                      ./../../configs/google_checks.xml;
                  };
                };
                extraPackages = with pkgs; [
                  checkstyle
                  luajitPackages.luacheck
                  python310Packages.flake8
                  statix
                ];

                lazy = true;
              }
              {
                plugin = formatter-nvim;
                config = readFile ./../../nvim/formatter.lua;
                commands = [ "Format" ];
                extraPackages = with pkgs; [
                  html-tidy
                  stylua
                  google-java-format
                  nixfmt
                  rustfmt
                  taplo
                  shfmt
                  nodePackages.prettier
                  nodePackages.fixjson
                  yapf
                  yamlfmt
                ];
              }
              {
                plugin = Comment-nvim;
                config = readFile ./../../nvim/comment.lua;
                events = [ "InsertEnter" "CursorMoved" ];
              }
              {
                # Cicaに登録されている絵文字を全角幅にしてくれる
                plugin = vim-ambiwidth;
                lazy = true;
              }
              {
                plugin = better-escape-nvim;
                config = readFile ./../../nvim/better-escape.lua;
                events = [ "InsertEnter" ];
              }
              {
                plugin = nvim-dd;
                config = readFile ./../../nvim/nvim-dd.lua;
                events = [ "InsertEnter" ];
              }
              {
                plugin = waitevent-nvim;
                config = readFile ./../../nvim/waitevent.lua;
                lazy = true;
              }
              {
                plugin = safe-close-window-nvim;
                config = readFile ./../../nvim/safe-close-window.lua;
                commands = [ "SafeCloseWindow" ];
              }
              {
                plugin = modicator-nvim;
                config = readFile ./../../nvim/modicator.lua;
              }
              {
                plugin = noice-nvim;
                depends = [ nui-nvim nvim-notify ];
                dependBundles = [ "treesitter" ];
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/noice.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                  };
                };
                lazy = true;
              }
              {
                plugin = nvim-fundo;
                depends = [ promise-async ];
                config = readFile ./../../nvim/fundo.lua;
                lazy = true;
                # run
                # require('fundo').install()
              }
              {
                plugin = nvim-early-retirement;
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/nvim-early-retirement.lua;
                };
                lazy = true;
              }
              {
                plugin = open-nvim;
                config = readFile ./../../nvim/open.lua;
                modules = [ "open" ];
              }
              {
                plugin = qf-nvim;
                config = readFile ./../../nvim/qf.lua;
                filetypes = [ "qf" ];
                commands = [ "Qnext" "Qprev" "Lnext" "Lprev" ];
              }
              {
                plugin = toolwindow-nvim;
                modules = [ "toolwindow" ];
              }
              {
                plugin = vimdoc-ja;
                config = "vim.cmd[[set helplang=ja,en]]";
                lazy = true;
              }
              # {
              #   plugin = which-key-nvim;
              #   config = readFile ./../../nvim/whichkey.lua;
              #   lazy = true;
              # }
              {
                plugin = nvim-bqf;
                config = readFile ./../../nvim/bqf.lua;
                modules = [ "bqf" ];
                events = [ "QuickFixCmdPre" ];
                dependBundles = [ "treesitter" ];
                extraPackages = with pkgs; [ fzf ];
              }
              # {
              #   plugin = qfview-nvim;
              #   config = readFile ./../../nvim/qfview.lua;
              #   events = [ "QuickFixCmdPre" ];
              #   lazy = true;
              # }
              {
                plugin = nvim-hlslens;
                config = readFile ./../../nvim/hlslens.lua;
                events = [ "CmdlineEnter" ];
              }
              {
                plugin = improved-search-nvim;
                config = readFile ./../../nvim/lua/improved-search.lua;
                events = [ "CursorMoved" ];
              }
              # {
              #   plugin = vim-asterisk;
              #   config = {
              #     lang = "vim";
              #     code = readFile ./../../nvim/asterisk.vim;
              #   };
              #   events = [ "CursorMoved" ];
              # }
              {
                plugin = mkdir-nvim;
                events = [ "CmdlineEnter" ];
              }
              {
                plugin = indent-o-matic;
                config = readFile ./../../nvim/indent-o-matic.lua;
                events = [ "CursorMoved" ];
              }
              {
                plugin = numb-nvim;
                config = readFile ./../../nvim/numb.lua;
                events = [ "CmdlineEnter" ];
              }
              # {
              #   plugin = indent-blankline-nvim;
              #   dependBundles = [ "treesitter" ];
              #   config = {
              #     lang = "lua";
              #     code = readFile ./../../nvim/indent-blankline.lua;
              #     args = { exclude_ft_path = ./../../nvim/shared/exclude_ft.lua; };
              #   };
              # }
              {
                # 対応する括弧の強調
                plugin = hlchunk-nvim;
                config = readFile ./../../nvim/hlchunk.lua;
                dependBundles = [ "treesitter" ];
                events = [ "CursorMoved" ];
              }
              {
                plugin = nvim-ufo;
                depends =
                  [ promise-async statuscol-nvim indent-blankline-nvim ];
                dependBundles = [ "treesitter" ];
                config = readFile ./../../nvim/ufo.lua;
                lazy = true;
              }
              {
                plugin = statuscol-nvim;
                config = readFile ./../../nvim/statuscol.lua;
              }
            ] ++ (flatten (map (bs: callPackage bs { }) [
              ./plugins/util.nix
              ./plugins/filetype.nix
            ]));
          bundles = with pkgs.vimPlugins;
            [
              {
                name = "treesitter";
                plugins = [
                  # WIP: `bash` does not work on lazy loading
                  (pkgs.pkgs-unstable.vimPlugins.nvim-treesitter.withPlugins
                    (p: with p; [ bash ]))
                  nvim-yati
                  # nvim-ts-rainbow2
                  # vim-matchup
                  nvim-treesitter-textobjects
                  {
                    plugin = rainbow-delimiters-nvim;
                    config = readFile ./../../nvim/rainbow-delimiters.lua;
                  }
                ];
                config = let
                  parser = pkgs.stdenv.mkDerivation {
                    name = "treesitter-all-grammars";
                    buildCommand = ''
                      mkdir -p $out/parser
                      echo "${
                        concatStringsSep ","
                        pkgs.pkgs-unstable.vimPlugins.nvim-treesitter.withAllGrammars.dependencies
                      }" \
                        | tr ',' '\n' \
                        | xargs -I {} find {} -not -type d \
                        | xargs -I {} ln -s {} $out/parser
                    '';
                  };
                in {
                  lang = "lua";
                  code = readFile ./../../nvim/treesitter.lua + ''
                    vim.opt.runtimepath:append("${parser}");
                  '';
                  args = { inherit parser; };
                };
                extraPackages = [ pkgs.pkgs-unstable.tree-sitter ];
                lazy = true;
              }
              {
                name = "skk";
                plugins = [{
                  plugin = skkeleton;
                  useDenops = true;
                }
                # wip
                # {
                #   plugin = skk-vconv-vim;
                #   depends = [ skkeleton ];
                #   extraPackages = with pkgs; [ python3Packages.pykakasi ];
                # }
                # {
                #   plugin = skkeleton_indicator-nvim;
                #   config = readFile ./../../nvim/skk-indicator.lua;
                # }
                  ];
                depends = [ denops-vim ];
                dependBundles = [ "ddc" ];
                config = {
                  lang = "vim";
                  code = readFile ./../../nvim/skk.vim;
                  args = {
                    jisyo_path = "${pkgs.skk-dicts}/share/SKK-JISYO.L";
                  };
                };
                events = [ "InsertEnter" "CmdlineEnter" ];
              }
              {
                name = "telescope";
                plugins = [
                  telescope-nvim
                  {
                    plugin = telescope-live-grep-args-nvim;
                    extraPackages = with pkgs; [ ripgrep ];
                  }
                  {
                    plugin = telescope-sonictemplate-nvim;
                    depends = [{
                      plugin = vim-sonictemplate.overrideAttrs (old: {
                        src = pkgs.nix-filter {
                          root = vim-sonictemplate.src;
                          exclude = [ "template/java" "template/make" ];
                        };
                      });
                      preConfig = ''
                        vim.g.sonictemplate_vim_template_dir = "${pkgs.sonicCustomTemplates}"
                        vim.g.sonictemplate_key = 0
                        vim.g.sonictemplate_intelligent_key = 0
                        vim.g.sonictemplate_postfix_key = 0
                      '';
                    }];
                  }
                ];
                depends = [ plenary-nvim ];
                config = readFile ./../../nvim/telescope.lua;
                commands = [ "Telescope" ];
              }
              {
                name = "neotest-bundle";
                plugins = [
                  {
                    plugin = neotest;
                    depends = [ plenary-nvim ];
                    dependBundles = [ "treesitter" "lsp" "dap" ];
                  }
                  neotest-python
                  neotest-plenary
                  neotest-go
                  neotest-jest
                  neotest-vitest
                  neotest-playwright
                  neotest-rspec
                  neotest-minitest
                  neotest-dart
                  neotest-testthat
                  neotest-phpunit
                  neotest-pest
                  neotest-rust
                  neotest-elixir
                  neotest-dotnet
                  neotest-scala
                  neotest-haskell
                  neotest-deno
                  {
                    plugin = neotest-vim-test;
                    depends = [ vim-test ];
                  }
                  overseer-nvim
                ];
                config = {
                  lang = "lua";
                  code = readFile ./../../nvim/neotest.lua;
                };
                commands = [ "Neotest" ];
              }
            ] ++ (flatten (map (bs: callPackage bs { }) [
              ./bundles/lsp-core.nix
              ./bundles/dap-core.nix
              ./bundles/ddc-core.nix
              ./bundles/ddu-core.nix
            ]));
          after = {
            ftplugin = with pkgs.vimPlugins; {
              qf = readFile ./../../nvim/after/ftplugin/qf.vim + ''
                " wip...
                " silent source ${qf-nvim}/after/ftplugin/qf.vim
                silent source ${nvim-bqf}/after/ftplugin/qf/bqf.vim
              '';
              ddu-ff = readFile ./../../nvim/after/ftplugin/ddu-ff.vim;
              ddu-ff-filter =
                readFile ./../../nvim/after/ftplugin/ddu-ff-filter.vim;
            };
          };
        };
      };
    };
}
