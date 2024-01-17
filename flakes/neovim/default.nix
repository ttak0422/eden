{ inputs, ... }: {
  imports = [ inputs.bundler.flakeModules.neovim ];
  perSystem = { system, config, pkgs, lib, ... }:
    let
      inherit (builtins) readFile;
      inherit (pkgs) callPackage;
      inherit (lib) flatten;
      inherit (lib.strings) concatStringsSep;

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
    in {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./overlays.nix inputs;
      };
      bundler-nvim = {
        default = {
          inherit after;
          package = pkgs.neovim-nightly;
          # logLevel = "debug";
          extraConfig = ''
            ${readFile ./../../nvim/disable-default-plugin.vim}
            ${readFile ./../../nvim/prelude.vim}
          '';
          extraLuaConfig = ''
            vim.loader.enable()
            dofile("${./../../nvim/lua/prelude.lua}")
            dofile("${./../../nvim/lua/keymap.lua}")
            ${readFile ./../../nvim/keymap.lua}
            if vim.g.neovide then
              dofile("${./../../nvim/neovide.lua}")
            end
          '';
          eagerPlugins = callPackage ./plugins/startup.nix { };
          lazyPlugins = with pkgs.vimPlugins;
            [
              {
                plugin = denops-translate-vim;
                preConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/denops-translate-pre.lua;
                };
                dependGroups = [ "denops" ];
                useDenops = true;
                onCommands = [ "Translate" ];
              }
              {
                plugin = flow-nvim;
                postConfig = {
                  code = readFile ./../../nvim/lua/flow.lua;
                  language = "lua";
                };
                onCommands = [ "FlowRunSelected" "FlowRunFile" "FlowLauncher" ];
              }
              # {
              #   plugin = denops-silicon-vim;
              #   preConfig = readFile ./../../nvim/lua/denops-silicon.lua;
              #   dependGroups = [ "denops" ];
              #   useDenops = true;
              #  onCommands = [ "Silicon" ];
              # }
              {
                plugin = detour-nvim;
                postConfig = {
                  code = readFile ./../../nvim/lua/detour.lua;
                  language = "lua";
                };
                onCommands = [ "Detour" ];
                onModules = [ "detour" ];
              }
              {
                plugin = marks-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/marks.lua;
                };
                useTimer = true;
              }
              {
                plugin = history-ignore-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/history-ignore.lua;
                };
                onEvents = [ "CmdlineEnter" ];
              }
              # {
              #   plugin = wf-nvim;
              #   config = readFile ./../../nvim/lua/wf.lua;
              #   dependPlugins = [ nvim-web-devicons ];
              #   modules = [ "wf.builtin.which_key" ];
              #   useTimer = true;
              # }
              # {
              #   plugin = auto-indent-nvim;
              #   config = readFile ./../../nvim/lua/autoindent.lua;
              #  onEvents = [ "InsertEnter" ];
              #   dependGroups = [ "treesitter" ];
              # }
              {
                plugin = winshift-nvim;
                onCommands = [ "WinShift" ];

              }
              {
                plugin = vim-startuptime;
                onCommands = [ "StartupTime" ];
              }
              # {
              #   # 画像のプレビュー
              #   plugin = chafa-nvim;
              #   config = readFile ./../../nvim/chafa.lua;
              #   dependPlugins = [ plenary-nvim baleia-nvim ];
              #   extraPackages = with pkgs; [ chafa ];
              #  onCommands = [ "ViewImage" ];
              # }
              {
                plugin = pkgs.pkgs-unstable.vimPlugins.markdown-preview-nvim;
                onFiletypes = [ "markdown" ];
              }
              {
                plugin = kensaku-command-vim;
                dependPlugins = [{
                  plugin = kensaku-vim;
                  useDenops = true;
                  dependPlugins = [ denops-vim ];
                }];
                onCommands = [ "Kensaku" ];
              }
              { plugin = nano-theme-nvim; }
              {
                plugin = harpoon-1;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/harpoon.lua;
                };
                dependPlugins = [ plenary-nvim ];
                onModules = [ "harpoon.mark" "harpoon.ui" ];
              }
              {
                plugin = copilot-lua;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/copilot.lua;
                };
                useTimer = true;
              }
              {
                plugin = nap-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/nap.lua;
                };
                dependPlugins = [{
                  plugin = vim-bufsurf;
                  postConfig = {
                    language = "lua";
                    code = readFile ./../../nvim/bufsurf.lua;
                  };
                }];
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = reacher-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/reacher.lua;
                };
                onModules = [ "reacher" ];
              }
              {
                plugin = nvim-window;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/nvim-window.lua;
                };
                onModules = [ "nvim-window" ];
              }
              {
                plugin = JABS-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/JABS.lua;
                };
                onCommands = [ "JABSOpen" ];
              }
              {
                plugin = leap-nvim;
                dependPlugins = [ vim-repeat ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/leap.lua;
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = flit-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/flit.lua;
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = tabout-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/tabout.lua;
                };
                dependGroups = [ "treesitter" ];
                onEvents = [ "InsertEnter" ];
              }
              {
                plugin = nvim-dap-go;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/dap-go.lua;
                };
                dependGroups = [ "dap" ];
                onFiletypes = [ "go" ];
                extraPackages = with pkgs; [ delve ];
              }
              {
                plugin = nvim-colorizer-lua;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/colorizer.lua;
                };
                onCommands = [ "ColorizerToggle" ];
              }
              {
                # タスクランナー
                plugin = overseer-nvim;
                dependPlugins = [ toggleterm-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/overseer.lua;
                };
                onCommands = [ "OverseerRun" ];
              }
              {
                plugin = project-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/project.lua;
                };
                useTimer = true;
              }
              { plugin = vim-jukit; }
              {
                plugin = codewindow-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/codewindow.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                  };
                };
                dependGroups = [ "treesitter" ];
                onEvents = [ "CursorHold" ];
                onModules = [ "codewindow" ];
              }
              {
                # require ts-parser norg.nvim
                plugin = neorg;
                dependPlugins = [
                  plenary-nvim
                  {
                    plugin = headlines-nvim;
                    dependGroups = [ "treesitter" ];
                    postConfig = {
                      language = "lua";
                      code = readFile ./../../nvim/headlines.lua;
                    };
                  }
                ];
                dependGroups = [ "treesitter" ];
                # startup = {
                #   language = "vim";
                #   code = readFile "${neorg}/ftdetect/norg./../../nvimvim";
                # };
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/neorg.lua;
                };
                onCommands = [ "Neorg" ];
                # onFiletypes = [ "norg" ];
              }
              {
                plugin = toggleterm-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/toggleterm.lua;
                };
                onCommands = [ "TermToggle" "TigTermToggle" ];
              }
              {
                plugin = nvim-FeMaco-lua;
                dependGroups = [ "treesitter" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/femaco.lua;
                };
                onCommands = [ "FeMaco" ];
              }
              {
                plugin = smart-splits-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/smart-splits.lua;
                };
                dependPlugins = [{
                  plugin = bufresize-nvim;
                  postConfig = {
                    language = "lua";
                    code = readFile ./../../nvim/lua/bufresize.lua;
                  };
                }];
                onModules = [ "smart-splits" ];
                onEvents = [ "WinNew" ];
              }
              {
                plugin = NeoZoom-lua;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/neo-zoom.lua;
                };
                onCommands = [ "NeoZoomToggle" ];
              }
              # {
              #   plugin = vim-fontzoom;
              #   prepostConfig = readFile ./../../nvim/fontzoom-pre.lua;
              #  onCommands = [ "Fontzoom" ];
              # }
              # {
              #   plugin = hologram-nvim;
              #   postConfig = readFile ./../../nvim/hologram.lua;
              #   onFiletypes = [ "markdown" ];
              # }
              {
                plugin = pets-nvim;
                dependPlugins = [ hologram-nvim nui-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/pets.lua;
                };
                onCommands = [ "PetsNew" ];
              }
              {
                # regex search panel.nvim
                plugin = nvim-spectre;
                dependPlugins = [ plenary-nvim nvim-web-devicons ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/spectre.lua;
                };
                extraPackages = with pkgs; [ gnused ripgrep ];
                onModules = [ "spectre" ];
              }
              {
                plugin = registers-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/registers.lua;
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = nvim-bufdel;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/bufdel.lua;
                };
                onCommands = [ "BufDel" "BufDel!" "BufDelAll" "BufDelOthers" ];
              }
              # {
              #   plugin = close-buffers-nvim;
              #   postConfig = readFile ./../../nvim/close-buffer.lua;
              #   onModules = [ "close_buffers" ];
              #  onCommands = [ "BDelete" "BDelete!" ];
              # }
              {
                plugin = nvim-tree-lua;
                dependPlugins = [ nvim-web-devicons circles-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/nvim-tree.lua;
                };
                onCommands = [ "NvimTreeToggle" ];
              }
              {
                plugin = neotree-nvim-3;
                dependPlugins = [ plenary-nvim nvim-web-devicons nui-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/neotree.lua;
                };
                onCommands = [ "Neotree" ];
              }
              {
                plugin = nvim-window-picker;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/window-picker.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                    exclude_buf_ft_path =
                      ./../../nvim/shared/exclude_buf_ft.lua;
                  };
                };
                onModules = [ "window-picker" ];
              }
              {
                plugin = obsidian-nvim;
                dependPlugins = [ plenary-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/obsidian.lua + ''
                    vim.cmd([[silent source ${obsidian-nvim}/after/syntax/markdown.vim]])
                  '';
                };
                onCommands = [
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
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/sidebar.lua;
                };
                onCommands = [ "SidebarNvimToggle" ];
              }
              {
                plugin = nvim-web-devicons;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/devicons.lua;
                };
              }
              # {
              #   # モードに応じたカーソルカラーを適用する
              #   plugin = modes-nvim;
              #   postConfig = {
              #     language = "lua";
              #     code = readFile ./../../nvim/modes.lua;
              #     args = { exclude_ft_path = ./../../nvim/shared/exclude_ft.lua; };
              #   };
              #   useTimer = true;
              # }
              {
                plugin = tint-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/tint.lua;
                };
                onEvents = [ "WinNew" ];
              }
              # {
              #   plugin = windows-nvim;
              #   dependPlugins = [ middleclass animation-nvim ];
              #   postConfig = {
              #     language = "lua";
              #     code = readFile ./../../nvim/windows.lua;
              #     args = { exclude_ft_path = ./../../nvim/shared/exclude_ft.lua; };
              #   };
              #  onEvents = [ "WinNew" ];
              # }
              # {
              #   plugin = nvim-treesitter-context;
              #   dependGroups = [ "treesitter" ];
              #   postConfig = readFile ./../../nvim/treesitter-context.lua;
              #  onEvents = [ "CursorMoved" ];
              # }
              {
                plugin = nvim-notify;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/notify.lua;
                };
                useTimer = true;
              }
              {
                plugin = dropbar-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/dropbar.lua;
                };
                dependPlugins = [ nvim-web-devicons ];
                useTimer = true;
              }
              # {
              #   plugin = windline-nvim;
              #   postConfig = readFile ./../../nvim/windline.lua;
              #   useTimer = true;
              # }
              {
                plugin = heirline-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/heirline.lua;
                };
                dependPlugins = [
                  plenary-nvim
                  nvim-web-devicons
                  {
                    plugin = piccolo-pomodoro-nvim;
                    postConfig = {
                      language = "lua";
                      code = readFile ./../../nvim/piccolo-pomodoro.lua;
                    };
                    onModules = [ "piccolo-pomodoro" ];
                  }
                  hydra-nvim
                ];
                dependGroups = [ "skk" ];
                useTimer = true;
              }
              # {
              #   plugin = nvim-scrollbar;
              #   dependPlugins = [ gitsigns-nvim ];
              #   postConfig = {
              #     language = "lua";
              #     code = readFile ./../../nvim/scrollbar.lua;
              #     args = {
              #       exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
              #       exclude_buf_ft_path = ./../../nvim/shared/exclude_buf_ft.lua;
              #     };
              #   };
              #  onEvents = [ "CursorMoved" ];
              # }
              {
                plugin = satellite-nvim;
                dependPlugins = [ gitsigns-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/satellite.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                  };
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = colorful-winsep-nvim;
                onEvents = [ "WinNew" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/winsep.lua;
                };
              }
              {
                plugin = scope-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/scope.lua;
                };
              }
              {
                plugin = bufferline-nvim;
                dependPlugins = [ scope-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/bufferline.lua;
                };
                useTimer = true;
              }
              {
                plugin = vim-nix;
                onFiletypes = [ "nix" ];
              }
              {
                plugin = vim-markdown;
                preConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/vim-markdown-pre.lua;
                };
                onFiletypes = [ "markdown" ];
              }
              # {
              #   plugin = neofsharp-vim;
              #   onFiletypes = [ "fs" "fsx" "fsi" "fsproj" ];
              # }
              {
                plugin = git-conflict-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/git-conflict.lua;
                };
                useTimer = true;
              }
              {
                plugin = gitsigns-nvim;
                dependPlugins = [ plenary-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/gitsign.lua;
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = gina-vim;
                postConfig = {
                  language = "vim";
                  code = readFile ./../../nvim/gina.vim;
                };
                onCommands = [ "Gina" ];
              }
              {
                plugin = gin-vim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/gin.lua;
                };
                dependPlugins = [ denops-vim ];
                onCommands = [
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
              # {
              #   plugin = neogit;
              #   dependPlugins = [ diffview-nvim plenary-nvim ];
              #   dependGroups = [ "telescope" ];
              #   postConfig = readFile ./../../nvim/lua/neogit.lua;
              #  onCommands = [ "Neogit" ];
              # }
              {
                plugin = diffview-nvim;
                dependPlugins = [ plenary-nvim ];
                onCommands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
              }
              # {
              #   plugin = vim-typo;
              #  onEvents = [ "BufEnter" ];
              # }
              {
                plugin = treesj;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/treesj.lua;
                };
                onModules = [ "treesj" ];
              }
              {
                plugin = neogen;
                dependGroups = [ "treesitter" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/neogen.lua;
                };
                onCommands = [ "Neogen" ];
              }
              {
                plugin = glance-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/glance.lua;
                };
                onCommands = [ "Glance" ];
              }
              {
                plugin = goto-preview;
                dependPlugins = [ tint-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/goto-preview.lua;
                };
                onModules = [ "goto-preview" ];
              }
              {
                plugin = legendary-nvim;
                dependGroups = [ "telescope" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/legendary.lua;
                };
                onCommands = [ "Legendary" ];
              }
              {
                # ys, ds, cs, ...
                plugin = nvim-surround;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/surround.lua;
                };
                onEvents = [ "InsertEnter" ];
              }
              {
                plugin = nvim-ts-autotag;
                dependGroups = [ "treesitter" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/ts-autotag.lua;
                };
                onFiletypes =
                  [ "javascript" "typescript" "jsx" "tsx" "vue" "html" ];
              }
              {
                plugin = todo-comments-nvim;
                dependPlugins = [ plenary-nvim trouble-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/todo-comments.lua;
                };
                onCommands = [
                  "TodoQuickFix"
                  "TodoLocList"
                  "TodoTrouble"
                  "TodoTelescope"
                ];
                extraPackages = [ pkgs.ripgrep ];
                useTimer = true;
              }
              {
                plugin = trouble-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/trouble.lua;
                };
                onModules = [ "trouble" ];
                onCommands = [ "TroubleToggle" ];
              }
              # {
              #   plugin = spaceless-nvim;
              #   postConfig = readFile ./../../nvim/spaceless.lua;
              #   useTimer = true;
              # }
              {
                plugin = trim-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/trim.lua;
                };
                useTimer = true;
              }
              {
                plugin = nvim_context_vt;
                dependGroups = [ "treesitter" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/context-vt.lua;
                };
                useTimer = true;
              }
              {
                plugin = nvim-lint;
                postConfig = {
                  language = "lua";
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

                useTimer = true;
              }
              # {
              #   plugin = formatter-nvim;
              #   postConfig = readFile ./../../nvim/formatter.lua;
              #  onCommands = [ "Format" ];
              #   extraPackages = with pkgs; [
              #     html-tidy
              #     stylua
              #     google-java-format
              #     nixfmt
              #     rustfmt
              #     taplo
              #     shfmt
              #     nodePackages.prettier
              #     nodePackages.fixjson
              #     yapf
              #     yamlfmt
              #   ];
              # }
              {
                plugin = Comment-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/comment.lua;
                };
                onEvents = [ "InsertEnter" "CursorMoved" ];
              }
              {
                # Cicaに登録されている絵文字を全角幅にしてくれる
                plugin = vim-ambiwidth;
                useTimer = true;
              }
              {
                plugin = better-escape-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/better-escape.lua;
                };
                onEvents = [ "InsertEnter" ];
              }
              {
                plugin = nvim-dd;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/nvim-dd.lua;
                };
                onEvents = [ "InsertEnter" ];
              }
              {
                plugin = waitevent-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/waitevent.lua;
                };
                useTimer = true;
              }
              {
                plugin = safe-close-window-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/safe-close-window.lua;
                };
                onCommands = [ "SafeCloseWindow" ];
              }
              {
                plugin = modicator-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/modicator.lua;
                };
              }
              {
                plugin = noice-nvim;
                dependPlugins = [ nui-nvim nvim-notify ];
                dependGroups = [ "treesitter" ];
                preConfig = {
                  language = "lua";
                  code = "-- test";
                };
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/noice.lua;
                  args = {
                    exclude_ft_path = ./../../nvim/shared/exclude_ft.lua;
                  };
                };
                useTimer = true;
              }
              {
                plugin = nvim-fundo;
                dependPlugins = [ promise-async ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/fundo.lua;
                };
                useTimer = true;
                # run
                # require('fundo').install()
              }
              {
                plugin = nvim-early-retirement;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/nvim-early-retirement.lua;
                };
                useTimer = true;
              }
              {
                plugin = open-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/open.lua;
                };
                onModules = [ "open" ];
              }
              {
                plugin = qf-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/qf.lua;
                };
                onFiletypes = [ "qf" ];
                onCommands = [ "Qnext" "Qprev" "Lnext" "Lprev" ];
              }
              {
                plugin = toolwindow-nvim;
                onModules = [ "toolwindow" ];
              }
              {
                plugin = vimdoc-ja;
                postConfig = ''
                  set helplang = "ja,en"
                '';
                useTimer = true;
              }
              {
                plugin = which-key-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/whichkey.lua;
                };
                useTimer = true;
              }
              {
                plugin = nvim-bqf;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/bqf.lua;
                };
                onModules = [ "bqf" ];
                onEvents = [ "QuickFixCmdPre" ];
                dependGroups = [ "treesitter" ];
                extraPackages = with pkgs; [ fzf ];
              }
              # {
              #   plugin = qfview-nvim;
              #   postConfig = readFile ./../../nvim/qfview.lua;
              #  onEvents = [ "QuickFixCmdPre" ];
              #   useTimer = true;
              # }
              {
                plugin = nvim-hlslens;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/hlslens.lua;
                };
                onEvents = [ "CmdlineEnter" ];
              }
              # {
              #   plugin = improved-search-nvim;
              #   postConfig = readFile ./../../nvim/lua/improved-search.lua;
              #  onEvents = [ "CursorMoved" ];
              # }
              {
                plugin = vim-asterisk;
                postConfig = {
                  language = "vim";
                  code = readFile ./../../nvim/asterisk.vim;
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = mkdir-nvim;
                onEvents = [ "CmdlineEnter" ];
              }
              {
                plugin = indent-o-matic;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/indent-o-matic.lua;
                };
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = numb-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/numb.lua;
                };
                onEvents = [ "CmdlineEnter" ];
              }
              # {
              #   plugin = indent-blankline-nvim;
              #   dependGroups = [ "treesitter" ];
              #   postConfig = {
              #     language = "lua";
              #     code = readFile ./../../nvim/indent-blankline.lua;
              #     args = { exclude_ft_path = ./../../nvim/shared/exclude_ft.lua; };
              #   };
              # }
              {
                # 対応する括弧の強調
                plugin = hlchunk-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/hlchunk.lua;
                };
                dependGroups = [ "treesitter" ];
                onEvents = [ "CursorMoved" ];
              }
              {
                plugin = nvim-ufo;
                dependPlugins =
                  [ promise-async statuscol-nvim indent-blankline-nvim ];
                dependGroups = [ "treesitter" ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/ufo.lua;
                };
                useTimer = true;
              }
              {
                plugin = statuscol-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/statuscol.lua;
                };
              }
              {
                plugin = tshjkl-nvim;
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/tshjkl.lua;
                };
                onEvents = [ "CursorMoved" ];
              }
            ] ++ (flatten (map (bs: callPackage bs { }) [
              ./plugins/util.nix
              ./plugins/filetype.nix
              ./plugins/none-ls.nix
            ]));
          lazyGroups = with pkgs.vimPlugins;
            [
              {
                name = "treesitter";
                plugins = [
                  # WIP: `bash` does not work on lazy loading
                  (pkgs.pkgs-unstable.vimPlugins.nvim-treesitter.withPlugins
                    (p: with p; [ bash ]))
                  nvim-yati
                  # nvim-ts-rainbow2
                  vim-matchup
                  nvim-treesitter-textobjects
                  {
                    plugin = rainbow-delimiters-nvim;
                    postConfig = {
                      language = "lua";
                      code = readFile ./../../nvim/rainbow-delimiters.lua;
                    };
                  }
                ];
                postConfig = let
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
                  language = "lua";
                  code = ''
                    vim.opt.runtimepath:append("${parser}");
                  '' + readFile ./../../nvim/lua/treesitter.lua;
                  args = { inherit parser; };
                };
                extraPackages = [ pkgs.pkgs-unstable.tree-sitter ];
                useTimer = true;
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
                #   dependPlugins = [ skkeleton ];
                #   extraPackages = with pkgs; [ python3Packages.pykakasi ];
                # }
                # {
                #   plugin = skkeleton_indicator-nvim;
                #   postConfig = readFile ./../../nvim/skk-indicator.lua;
                # }
                  ];
                dependPlugins = [ denops-vim ];
                dependGroups = [ "ddc" ];
                postConfig = {
                  language = "vim";
                  code = readFile ./../../nvim/skk.vim;
                  args = {
                    jisyo_path = "${pkgs.skk-dicts}/share/SKK-JISYO.L";
                  };
                };
                onEvents = [ "InsertEnter" "CmdlineEnter" ];
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
                    dependPlugins = [{
                      plugin = vim-sonictemplate.overrideAttrs (old: {
                        src = pkgs.nix-filter {
                          root = vim-sonictemplate.src;
                          exclude = [ "template/java" "template/make" ];
                        };
                      });
                      preConfig = {
                        language = "lua";
                        code = ''
                          vim.g.sonictemplate_vim_template_dir = "${pkgs.sonicCustomTemplates}"
                          vim.g.sonictemplate_key = 0
                          vim.g.sonictemplate_intelligent_key = 0
                          vim.g.sonictemplate_postfix_key = 0
                        '';
                      };
                    }];
                  }
                ];
                dependPlugins = [ plenary-nvim ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/telescope.lua;
                };
                onCommands = [ "Telescope" ];
              }
              {
                name = "neotest-bundle";
                plugins = [
                  {
                    plugin = neotest;
                    dependPlugins = [ plenary-nvim ];
                    dependGroups = [ "treesitter" "lsp" "dap" ];
                  }
                  neotest-java
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
                    dependPlugins = [ vim-test ];
                  }
                  overseer-nvim
                ];
                postConfig = {
                  language = "lua";
                  code = readFile ./../../nvim/lua/neotest.lua;
                };
                onCommands = [ "Neotest" ];
              }
            ] ++ (flatten (map (bs: callPackage bs { }) [
              ./groups/lsp-core.nix
              ./groups/dap-core.nix
              ./groups/ddc-core.nix
              ./groups/ddu-core.nix
            ]));
        };
      };
    };
}
