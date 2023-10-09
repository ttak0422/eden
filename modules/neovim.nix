{ self, inputs, ... }: {
  flake.nixosModules.eden-nvim = { pkgs, lib, flags, system, ... }:
    let
      inherit (builtins) readFile;
      inherit (pkgs.stdenv) isDarwin;
      inherit (lib.attrsets) optionalAttrs;

      startPlugins = with pkgs.vimPlugins; [
        vim-sensible
        # vim-poslist
        # {
        #   plugin = tokyonight-nvim;
        #   startup = "vim.cmd[[colorscheme tokyonight]] ";
        # }
        # {
        #   plugin = everforest;
        #   startup = ''
        #     vim.cmd([[
        #       set background=dark
        #       let g:everforest_background = 'soft'
        #       colorscheme everforest
        #       hi NormalFloat ctermbg=NONE guibg=NONE
        #       hi FloatBorder ctermbg=NONE guibg=NONE
        #     ]])
        #   '';
        # }
        {
          plugin = kanagawa-nvim;
          startup = readFile ./../nvim/kanagawa.lua;
        }
        # {
        #   plugin = nvim-tundra;
        #   startup = readFile ./../nvim/tundra.lua;
        # }
        {
          plugin = nvim-config-local;
          startup = readFile ./../nvim/config-local.lua;
        }
        {
          plugin = stickybuf-nvim;
          startup = readFile ./../nvim/stickybuf.lua;
        }
        {
          plugin = direnv-vim;
          startup = readFile ./../nvim/direnv.lua;
        }
      ];

      ai = with pkgs.vimPlugins;
        if flags ? copilot && flags.copilot then [{
          plugin = copilot-lua;
          config = readFile ./../nvim/copilot.lua;
          lazy = true;
        }] else
          [ ];

      basic = with pkgs.vimPlugins;
        [
          # {
          #   # 対応するカッコの強調表示
          #   plugin = sentiment-nvim;
          #   config = readFile ./../nvim/sentiment.lua;
          #   lazy = true;
          # }
          # {
          #   # Enterでいいかんじにテキストオブジェクトを選択
          #   plugin = wildfire-vim;
          #   events = [ "CursorMoved" ];
          # }
          # {
          #   # Enterでいいかんじにテキストオブジェクトを選択
          #   plugin = wildfire-nvim;
          #   config = readFile ./../nvim/wildfire.lua;
          #   events = [ "CursorMoved" ];
          # }
          {
            # quickfixの高さを調整
            plugin = qfheight-nvim;
            config = readFile ./../nvim/qfheight.lua;
            filetypes = [ "qf" ];
            events = [ "QuickFixCmdPre" ];
          }
        ];

      motion = with pkgs.vimPlugins; [
        {
          plugin = nap-nvim;
          config = readFile ./../nvim/nap.lua;
          depends = [{
            plugin = vim-bufsurf;
            config = readFile ./../nvim/bufsurf.lua;
          }];
          events = [ "CursorMoved" ];
        }
        {
          plugin = reacher-nvim;
          config = readFile ./../nvim/reacher.lua;
          modules = [ "reacher" ];
        }
        {
          plugin = nvim-window;
          config = readFile ./../nvim/nvim-window.lua;
          modules = [ "nvim-window" ];
        }
        {
          plugin = JABS-nvim;
          config = readFile ./../nvim/JABS.lua;
          commands = [ "JABSOpen" ];
        }
        {
          plugin = leap-nvim;
          depends = [ vim-repeat ];
          config = readFile ./../nvim/leap.lua;
          events = [ "CursorMoved" ];
        }
        {
          plugin = flit-nvim;
          config = readFile ./../nvim/flit.lua;
          events = [ "CursorMoved" ];
        }
        {
          plugin = tabout-nvim;
          config = readFile ./../nvim/tabout.lua;
          dependBundles = [ "treesitter" ];
          events = [ "InsertEnter" ];
        }
      ];
      tool = with pkgs.vimPlugins; [
        {
          plugin = nvim-dap-go;
          config = readFile ./../nvim/dap-go.lua;
          dependBundles = [ "dap" ];
          filetypes = [ "go" ];
          extraPackages = with pkgs; [ delve ];
        }
        {
          plugin = nvim-colorizer-lua;
          config = readFile ./../nvim/colorizer.lua;
          commands = [ "ColorizerToggle" ];
        }
        {
          plugin = overseer-nvim;
          depends = [ toggleterm-nvim ];
          config = readFile ./../nvim/overseer.lua;
          commands = [ "OverseerRun" ];
        }
        # {
        #   plugin = auto-session;
        #   config = readFile ./../nvim/auto-session.lua;
        #   dependBundles = [ "telescope" ];
        #   commands = [ "auto-session.session-lens" ];
        #   lazy = true;
        # }
        {
          plugin = project-nvim;
          config = readFile ./../nvim/project.lua;
          lazy = true;
        }
        { plugin = vim-jukit; }
        {
          plugin = codewindow-nvim;
          config = {
            lang = "lua";
            code = readFile ./../nvim/codewindow.lua;
            args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
          };
          dependBundles = [ "treesitter" ];
          events = [ "CursorHold" ];
          modules = [ "codewindow" ];
          # lazy = true;
        }
        {
          # require ts-parser norg.nvim
          plugin = neorg;
          depends = [
            plenary-nvim
            {
              plugin = headlines-nvim;
              dependBundles = [ "treesitter" ];
              config = readFile ./../nvim/headlines.lua;
            }
          ];
          dependBundles = [ "treesitter" ];
          # startup = {
          #   lang = "vim";
          #   code = readFile "${neorg}/ftdetect/norg./../nvimvim";
          # };
          config = readFile ./../nvim/neorg.lua;
          commands = [ "Neorg" ];
          # filetypes = [ "norg" ];
        }
        {
          plugin = toggleterm-nvim;
          config = {
            lang = "lua";
            code = readFile ./../nvim/toggleterm.lua;
          };
          commands = [ "TermToggle" "TigTermToggle" ];
        }
        {
          plugin = nvim-FeMaco-lua;
          dependBundles = [ "treesitter" ];
          config = readFile ./../nvim/femaco.lua;
          commands = [ "FeMaco" ];
        }
        {
          plugin = smart-splits-nvim;
          config = readFile ./../nvim/smart-splits.lua;
          depends = [{
            plugin = bufresize-nvim;
            config = readFile ./../nvim/bufresize.lua;
            events = [ "WinNew" ];
          }];
          modules = [ "smart-splits" ];
        }
        {
          plugin = NeoZoom-lua;
          config = readFile ./../nvim/neo-zoom.lua;
          commands = [ "NeoZoomToggle" ];
        }
        # {
        #   plugin = vim-fontzoom;
        #   preConfig = readFile ./../nvim/fontzoom-pre.lua;
        #   commands = [ "Fontzoom" ];
        # }
        # {
        #   plugin = hologram-nvim;
        #   config = readFile ./../nvim/hologram.lua;
        #   filetypes = [ "markdown" ];
        # }
        {
          plugin = pets-nvim;
          depends = [ hologram-nvim nui-nvim ];
          config = readFile ./../nvim/pets.lua;
          commands = [ "PetsNew" ];
        }
        {
          # regex search panel.nvim
          plugin = nvim-spectre;
          depends = [ plenary-nvim nvim-web-devicons ];
          config = readFile ./../nvim/spectre.lua;
          extraPackages = with pkgs; [ gnused ripgrep ];
          modules = [ "spectre" ];
        }
        {
          plugin = registers-nvim;
          config = readFile ./../nvim/registers.lua;
          events = [ "CursorMoved" ];
        }
        {
          plugin = nvim-bufdel;
          config = readFile ./../nvim/bufdel.lua;
          commands = [ "BufDel" "BufDel!" "BufDelAll" "BufDelOthers" ];
        }
        # {
        #   plugin = close-buffers-nvim;
        #   config = readFile ./../nvim/close-buffer.lua;
        #   modules = [ "close_buffers" ];
        #   commands = [ "BDelete" "BDelete!" ];
        # }
        {
          plugin = nvim-tree-lua;
          depends = [ nvim-web-devicons circles-nvim ];
          config = readFile ./../nvim/nvim-tree.lua;
          commands = [ "NvimTreeToggle" ];
        }
        {
          plugin = neotree-nvim-3;
          depends = [ plenary-nvim nvim-web-devicons nui-nvim ];
          config = readFile ./../nvim/neotree.lua;
          commands = [ "Neotree" ];
        }
        {
          plugin = nvim-window-picker;
          config = {
            lang = "lua";
            code = readFile ./../nvim/window-picker.lua;
            args = {
              exclude_ft_path = ./../nvim/shared/exclude_ft.lua;
              exclude_buf_ft_path = ./../nvim/shared/exclude_buf_ft.lua;
            };
          };
          modules = [ "window-picker" ];
        }
        {
          plugin = obsidian-nvim;
          depends = [ plenary-nvim ];
          config = readFile ./../nvim/obsidian.lua + ''
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
      ];
      ui = with pkgs.vimPlugins; [
        {
          plugin = sidebar-nvim;
          config = readFile ./../nvim/sidebar.lua;
          commands = [ "SidebarNvimToggle" ];
        }
        {
          plugin = nvim-web-devicons;
          config = readFile ./../nvim/devicons.lua;
        }
        # {
        #   # モードに応じたカーソルカラーを適用する
        #   plugin = modes-nvim;
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/modes.lua;
        #     args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
        #   };
        #   lazy = true;
        # }
        {
          plugin = tint-nvim;
          config = readFile ./../nvim/tint.lua;
          events = [ "WinNew" ];
        }
        # {
        #   plugin = windows-nvim;
        #   depends = [ middleclass animation-nvim ];
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/windows.lua;
        #     args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
        #   };
        #   events = [ "WinNew" ];
        # }
        # {
        #   plugin = nvim-treesitter-context;
        #   dependBundles = [ "treesitter" ];
        #   config = readFile ./../nvim/treesitter-context.lua;
        #   events = [ "CursorMoved" ];
        # }
        {
          plugin = nvim-notify;
          config = readFile ./../nvim/notify.lua;
          lazy = true;
        }
        # {
        #   plugin = winbar-nvim;
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/winbar.lua;
        #     args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
        #   };
        #   lazy = true;
        # }
        {
          plugin = dropbar-nvim;
          config = readFile ./../nvim/dropbar.lua;
          depends = [ nvim-web-devicons ];
          lazy = true;
        }
        # {
        #   plugin = windline-nvim;
        #   config = readFile ./../nvim/windline.lua;
        #   lazy = true;
        # }
        {
          plugin = heirline-nvim;
          config = readFile ./../nvim/heirline.lua;
          depends = [
            plenary-nvim
            nvim-web-devicons
            {
              plugin = piccolo-pomodoro-nvim;
              config = readFile ./../nvim/piccolo-pomodoro.lua;
              modules = [ "piccolo-pomodoro" ];
            }
          ];
          dependBundles = [ "skk" ];
          lazy = true;
        }
        # {
        #   plugin = nvim-scrollbar;
        #   depends = [ gitsigns-nvim ];
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/scrollbar.lua;
        #     args = {
        #       exclude_ft_path = ./../nvim/shared/exclude_ft.lua;
        #       exclude_buf_ft_path = ./../nvim/shared/exclude_buf_ft.lua;
        #     };
        #   };
        #   events = [ "CursorMoved" ];
        # }
        {
          plugin = satellite-nvim;
          depends = [ gitsigns-nvim ];
          config = {
            lang = "lua";
            code = readFile ./../nvim/satellite.lua;
            args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
          };
          events = [ "CursorMoved" ];
        }
        # {
        #   # MEMO:
        #   #   - `UpdateRemotePlugins` required.
        #   #   - withPython3 required.
        #   plugin = wilder-nvim;
        #   depends = [ fzy-lua-native ];
        #   config = readFile ./../nvim/wilder.lua;
        #   events = [ "CmdlineEnter" ];
        #   extraPackages = with pkgs; [ fd ];
        # }
        # {
        #   plugin = SmoothCursor-nvim;
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/smoothcursor.lua;
        #     args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
        #   };
        #   events = [ "CursorMoved" ];
        # }
        # {
        #   plugin = minimap-vim;
        #   preConfig = {
        #     lang = "lua";
        #     code = readFile ./../nvim/minimap-pre.lua;
        #   };
        #   config = readFile ./../nvim/minimap.lua;
        #   commands = [ "MinimapToggle" ];
        #   extraPackages = [ pkgs.code-minimap ];
        # }
        {
          plugin = colorful-winsep-nvim;
          events = [ "WinNew" ];
          config = readFile ./../nvim/winsep.lua;
        }
        {
          plugin = scope-nvim;
          config = readFile ./../nvim/scope.lua;
        }
        {
          plugin = bufferline-nvim;
          depends = [ scope-nvim ];
          config = readFile ./../nvim/bufferline.lua;
          lazy = true;
        }
      ];
      lang = with pkgs.vimPlugins; [
        {
          plugin = vim-nix;
          filetypes = [ "nix" ];
        }
        {
          plugin = vim-markdown;
          preConfig = readFile ./../nvim/vim-markdown-pre.lua;
          filetypes = [ "markdown" ];
        }
        # {
        #   plugin = neofsharp-vim;
        #   filetypes = [ "fs" "fsx" "fsi" "fsproj" ];
        # }
      ];
      git = with pkgs.vimPlugins; [
        {
          plugin = git-conflict-nvim;
          config = readFile ./../nvim/git-conflict.lua;
          lazy = true;
        }
        {
          plugin = gitsigns-nvim;
          depends = [ plenary-nvim ];
          config = readFile ./../nvim/gitsign.lua;
          events = [ "CursorMoved" ];
        }
        {
          plugin = gin-vim;
          config = readFile ./../nvim/gin.lua;
          depends = [ denops-vim ];
          # TODO: support denops lazy load
          # commands = [ "Gin" "GinBuffer" "GinLog" "GinStatus" "GinDiff" ];
          lazy = true;
        }
        {
          plugin = neogit;
          depends = [ diffview-nvim plenary-nvim ];
          config = readFile ./../nvim/neogit.lua;
          commands = [ "Neogit" ];
        }
        {
          plugin = diffview-nvim;
          depends = [ plenary-nvim ];
          commands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
        }
      ];
      code = with pkgs.vimPlugins; [
        # {
        #   plugin = vim-typo;
        #   events = [ "BufEnter" ];
        # }
        {
          plugin = treesj;
          config = readFile ./../nvim/treesj.lua;
          modules = [ "treesj" ];
        }
        {
          plugin = neogen;
          dependBundles = [ "treesitter" ];
          config = readFile ./../nvim/neogen.lua;
          commands = [ "Neogen" ];
        }
        {
          plugin = glance-nvim;
          config = readFile ./../nvim/glance.lua;
          commands = [ "Glance" ];
        }
        {
          plugin = goto-preview;
          depends = [ tint-nvim ];
          config = readFile ./../nvim/goto-preview.lua;
          modules = [ "goto-preview" ];
        }
        {
          plugin = legendary-nvim;
          dependBundles = [ "telescope" ];
          config = readFile ./../nvim/legendary.lua;
          commands = [ "Legendary" ];
        }
        {
          # ys, ds, cs, ...
          plugin = nvim-surround;
          config = readFile ./../nvim/surround.lua;
          events = [ "InsertEnter" ];
        }
        {
          plugin = nvim-ts-autotag;
          dependBundles = [ "treesitter" ];
          config = readFile ./../nvim/ts-autotag.lua;
          filetypes = [ "javascript" "typescript" "jsx" "tsx" "vue" "html" ];
        }
        {
          plugin = todo-comments-nvim;
          depends = [ plenary-nvim trouble-nvim ];
          config = readFile ./../nvim/todo-comments.lua;
          commands =
            [ "TodoQuickFix" "TodoLocList" "TodoTrouble" "TodoTelescope" ];
          extraPackages = [ pkgs.ripgrep ];
          lazy = true;
        }
        {
          plugin = trouble-nvim;
          config = readFile ./../nvim/trouble.lua;
          modules = [ "trouble" ];
          commands = [ "TroubleToggle" ];
        }
        # {
        #   plugin = spaceless-nvim;
        #   config = readFile ./../nvim/spaceless.lua;
        #   lazy = true;
        # }
        {
          plugin = trim-nvim;
          config = readFile ./../nvim/trim.lua;
          lazy = true;
        }
        {
          plugin = nvim_context_vt;
          dependBundles = [ "treesitter" ];
          config = readFile ./../nvim/context-vt.lua;
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
        #   '' + readFile ./../nvim/treesitter.lua;
        #   extraPackages = [ pkgs.tree-sitter ];
        # }
        {
          plugin = nvim-lint;
          config = {
            lang = "lua";
            code = readFile ./../nvim/lint.lua;
            args = {
              checkstyle_config_file_path = ./../configs/google_checks.xml;
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
          # Java
          plugin = nvim-jdtls;
          depends = [ ];
          dependBundles = [ "lsp" ];
          config = let jdtLsp = pkgs.jdt-language-server;
          in {
            lang = "lua";
            code = readFile ./../nvim/jdtls.lua;
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
              on_attach_path = ./../nvim/shared/on_attach.lua;
              capabilities_path = ./../nvim/shared/capabilities.lua;
              java_bin = "${pkgs.jdk17}/bin/java";
              jdtls_config = "${jdtLsp}/share/config";
              lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
              jdtls_jar_pattern =
                "${jdtLsp}/share/java/plugins/org.eclipse.equinox.launcher_*.jar";
              jdtls_settings_path = ./../nvim/jdtls_settings.lua;
              java_debug_jar_pattern =
                "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar";
              java_test_jar_pattern =
                "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar";
              jol_jar = pkgs.javaPackages.jol;

            };
          };
          filetypes = [ "java" ];
        }
        # {
        #   # typescript (node)
        #   plugin = typescript-nvim;
        #   dependBundles = [ "lsp" ];
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/typescript.lua;
        #     args = {
        #       on_attach_path = ./../nvim/shared/on_attach.lua;
        #       capabilities_path = ./../nvim/shared/capabilities.lua;
        #       tsserver_cmd = [
        #         "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server"
        #         "--stdio"
        #       ];
        #       tsserver_path =
        #         "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib/";
        #     };
        #   };
        #   filetypes = [ "typescript" ];
        # }
        # {
        #   plugin = typescript-tool-nvim;
        #   depends = [ plenary-nvim nvim-lspconfig ];
        #   dependBundles = [ "lsp" ];
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/typescript-tool.lua;
        #     args = { on_attach_path = ./../nvim/shared/on_attach.lua; };
        #   };
        #   filetypes = [ "typescript" "javascript" ];
        # }
        {
          plugin = deno-nvim;
          dependBundles = [ "lsp" ];
          config = {
            lang = "lua";
            code = readFile ./../nvim/deno.lua;
            args = {
              on_attach_path = ./../nvim/shared/on_attach.lua;
              capabilities_path = ./../nvim/shared/capabilities.lua;
            };
          };
          filetypes = [ "typescript" ];
        }
        {
          # Rust
          plugin = rust-tools-nvim;
          depends = [ plenary-nvim nvim-dap ];
          dependBundles = [ "lsp" ];
          config = {
            lang = "lua";
            code = readFile ./../nvim/rust-tools.lua;
            args = {
              on_attach_path = ./../nvim/shared/on_attach.lua;
              capabilities_path = ./../nvim/shared/capabilities.lua;
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
            code = readFile ./../nvim/haskell-tools.lua;
            args = {
              on_attach_path = ./../nvim/shared/on_attach.lua;
              capabilities_path = ./../nvim/shared/capabilities.lua;
            };
          };
          filetypes = [ "haskell" ];
        }
        {
          # Flutter
          plugin = flutter-tools-nvim;
          depends = [ plenary-nvim ];
          dependBundles = [ "lsp" ];
          config = readFile ./../nvim/flutter-tools.lua;
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
            code = readFile ./../nvim/ionide.lua;
            args = {
              on_attach_path = ./../nvim/shared/on_attach.lua;
              capabilities_path = ./../nvim/shared/capabilities.lua;
            };
          };
          filetypes = [ "fsharp" ];
        }
        {
          plugin = formatter-nvim;
          config = readFile ./../nvim/formatter.lua;
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
          ];
        }
        {
          plugin = Comment-nvim;
          config = readFile ./../nvim/comment.lua;
          events = [ "InsertEnter" "CursorMoved" ];
        }
        {
          plugin = denops-vim;
          # 全体で管理
          # extraPackages = with pkgs; [ deno ];
        }
      ];
      custom = with pkgs.vimPlugins; [
        {
          # Cicaに登録されている絵文字を全角幅にしてくれる
          plugin = vim-ambiwidth;
          lazy = true;
        }
        {
          plugin = better-escape-nvim;
          config = readFile ./../nvim/better-escape.lua;
          events = [ "InsertEnter" ];
        }
        {
          plugin = nvim-dd;
          config = readFile ./../nvim/nvim-dd.lua;
          events = [ "InsertEnter" ];
        }
        {
          plugin = waitevent-nvim;
          config = readFile ./../nvim/waitevent.lua;
          lazy = true;
        }
        {
          plugin = safe-close-window-nvim;
          config = readFile ./../nvim/safe-close-window.lua;
          commands = [ "SafeCloseWindow" ];
        }
        {
          plugin = modicator-nvim;
          config = readFile ./../nvim/modicator.lua;
        }
        # {
        #   plugin = nvim-spider;
        #   config = readFile ./../nvim/spider.lua;
        #   modules = [ "spider" ];
        # }
        {
          plugin = noice-nvim;
          depends = [ nui-nvim nvim-notify ];
          dependBundles = [ "treesitter" ];
          config = {
            lang = "lua";
            code = readFile ./../nvim/noice.lua;
            args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
          };
          lazy = true;

        }
        {
          plugin = nvim-fundo;
          depends = [ promise-async ];
          config = readFile ./../nvim/fundo.lua;
          lazy = true;
          # run
          # require('fundo').install()
        }
        {
          plugin = nvim-early-retirement;
          config = {
            lang = "lua";
            code = readFile ./../nvim/nvim-early-retirement.lua;
          };
          lazy = true;
        }
        {
          plugin = open-nvim;
          config = readFile ./../nvim/open.lua;
          modules = [ "open" ];
        }
        {
          plugin = qf-nvim;
          config = readFile ./../nvim/qf.lua;
          filetypes = [ "qf" ];
          events = [ "QuickFixCmdPre" ];
          lazy = true;
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
        {
          plugin = which-key-nvim;
          config = readFile ./../nvim/whichkey.lua;
          lazy = true;
        }
        {
          plugin = nvim-bqf;
          config = readFile ./../nvim/bqf.lua;
          events = [ "QuickFixCmdPre" ];
          lazy = true;
        }
        # {
        #   plugin = qfview-nvim;
        #   config = readFile ./../nvim/qfview.lua;
        #   events = [ "QuickFixCmdPre" ];
        #   lazy = true;
        # }
        {
          plugin = nvim-hlslens;
          config = readFile ./../nvim/hlslens.lua;
          events = [ "CmdlineEnter" ];
        }
        {
          plugin = vim-asterisk;
          config = {
            lang = "vim";
            code = readFile ./../nvim/asterisk.vim;
          };
          events = [ "CmdlineEnter" ];
        }

        {
          plugin = mkdir-nvim;
          events = [ "CmdlineEnter" ];
        }
        {
          plugin = indent-o-matic;
          config = readFile ./../nvim/indent-o-matic.lua;
          events = [ "CursorMoved" ];
        }
        {
          plugin = numb-nvim;
          config = readFile ./../nvim/numb.lua;
          events = [ "CmdlineEnter" ];
        }
        # {
        #   plugin = indent-blankline-nvim;
        #   dependBundles = [ "treesitter" ];
        #   config = {
        #     lang = "lua";
        #     code = readFile ./../nvim/indent-blankline.lua;
        #     args = { exclude_ft_path = ./../nvim/shared/exclude_ft.lua; };
        #   };
        # }
        {
          # 対応する括弧の強調
          plugin = hlchunk-nvim;
          config = readFile ./../nvim/hlchunk.lua;
          events = [ "CursorMoved" ];
        }
        {
          plugin = nvim-ufo;
          depends = [ promise-async statuscol-nvim indent-blankline-nvim ];
          dependBundles = [ "treesitter" ];
          config = readFile ./../nvim/ufo.lua;
          lazy = true;
        }
        {
          plugin = statuscol-nvim;
          config = readFile ./../nvim/statuscol.lua;
        }
      ];
      bundles =
        # let
        #   nvim-treesitter' = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
        #   cfg = ''
        #     vim.opt.runtimepath:append("${
        #       pkgs.symlinkJoin {
        #         name = "treesitter-parsers";
        #         paths = nvim-treesitter'.dependencies;
        #       }
        #     }")
        #   '';
        # in
        with pkgs.vimPlugins; [
          {
            name = "treesitter";
            plugins = [
              nvim-treesitter
              nvim-yati
              # vim-matchup
              nvim-treesitter-textobjects
              {
                plugin = rainbow-delimiters-nvim;
                config = readFile ./../nvim/rainbow-delimiters.lua;
              }
            ];
            config = readFile ./../nvim/treesitter.lua;
            extraPackages = [ pkgs.pkgs-unstable.tree-sitter ];
            lazy = true;
          }
          {
            name = "skk";
            plugins = [
              skkeleton
              # wip
              # {
              #   plugin = skk-vconv-vim;
              #   depends = [ skkeleton ];
              #   extraPackages = with pkgs; [ python3Packages.pykakasi ];
              # }
              {
                plugin = skkeleton_indicator-nvim;
                config = readFile ./../nvim/skk-indicator.lua;
              }
            ];
            # depends = [ denops-vim ];
            dependBundles = [ "ddc" ];
            config = {
              lang = "vim";
              code = readFile ./../nvim/skk.vim;
              args = { jisyo_path = "${pkgs.skk-dicts}/share/SKK-JISYO.L"; };
            };
            lazy = true;
          }
          {
            name = "telescope";
            plugins = [
              telescope-nvim
              telescope-ui-select-nvim
              {
                plugin = telescope-repo-nvim;
                extraPackages = with pkgs; [ fd glow bat ];
              }
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
            config = readFile ./../nvim/telescope.lua;
            commands = [ "Telescope" ];
          }
          {
            name = "lsp";
            plugins = [
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
                ]) ++ (with pkgs.pkgs-unstable; [ nixd ]);
                config = {
                  lang = "lua";
                  code = readFile ./../nvim/lspconfig.lua;
                  args = {
                    on_attach_path = ./../nvim/shared/on_attach.lua;
                    capabilities_path = ./../nvim/shared/capabilities.lua;
                    eslint_cmd = [
                      "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-eslint-language-server"
                      "--stdio"
                    ];
                  };
                };
                # depends = [{
                #   plugin = neodev-nvim;
                #   config = readFile ./../nvim/neodev.lua;
                # }];
                lazy = true;
              }
              {
                plugin = lsp-lens-nvim;
                config = readFile ./../nvim/lsp-lens.lua;
              }
              # {
              #   plugin = actions-preview-nvim;
              #   config = readFile ./../nvim/actions-preview.lua;
              #   dependBundles = [ "telescope" ];
              #   modules = [ "actions-preview" ];
              # }
              {
                plugin = lsp-inlayhints-nvim;
                config = readFile ./../nvim/inlayhints.lua;
              }
              # {
              #   # カーソルの対応する要素のハイライト.
              #   plugin = vim-illuminate;
              #   config = readFile ./../nvim/illuminate.lua;
              # }
              # {
              #   plugin = hover-nvim;
              #   config = readFile ./../nvim/hover.lua;
              # }
              # {
              #   plugin = pretty_hover;
              #   config = readFile ./../nvim/pretty-hover.lua;
              # }
              {
                plugin = diagflow-nvim;
                config = readFile ./../nvim/diagflow.lua;
              }
              {
                plugin = nvim-vtsls;
                config = readFile ./../nvim/vtsls.lua;
              }
              noice-nvim
            ];
            depends = [{
              plugin = fidget-nvim;
              config = readFile ./../nvim/fidget.lua;
            }];
            dependBundles = [ "ddc" ];
            lazy = true;
          }
          {
            name = "dap";
            plugins = [
              nvim-dap
              nvim-dap-go
              nvim-dap-ui
              nvim-dap-virtual-text
              overseer-nvim
            ];
            dependBundles = [ "treesitter" ];
            config = readFile ./../nvim/dap.lua;
            modules = [ "dap" "dapui" ];
            filetypes = [ "java" ];
          }
          {
            name = "ddc";
            plugins = [
              ddc-vim
              {
                plugin = ddc-ui-pum;
                depends = [{
                  plugin = pum-vim;
                  depends = [
                    { plugin = noice-nvim; }
                    {
                      plugin = nvim-autopairs;
                      dependBundles = [ "treesitter" ];
                      startup = ''
                        vim.cmd([[inoremap <silent><expr> <CR>  "\<C-g>u\<c-r>=v:lua.require'nvim-autopairs'.autopairs_cr()\<CR>"]])
                      '';
                      config = readFile ./../nvim/autopairs.lua;
                      events = [ "InsertEnter" ];
                      modules = [ "nvim-autopairs" ];
                    }
                  ];
                  config = {
                    lang = "vim";
                    code = readFile ./../nvim/pum.vim;
                  };
                }];
              }
              ddc-buffer
              ddc-converter_remove_overlap
              ddc-converter_truncate
              ddc-fuzzy
              ddc-matcher_head
              ddc-matcher_length
              ddc-sorter_itemsize
              ddc-sorter_rank
              ddc-source-around
              ddc-source-cmdline
              ddc-source-cmdline-history
              ddc-source-file
              ddc-source-input
              ddc-source-line
              ddc-sorter_reverse
              {
                plugin = ddc-source-vsnip;
                depends = [{
                  plugin = vim-vsnip;
                  depends = [ tabout-nvim ];
                  config = {
                    lang = "vim";
                    code = readFile ./../nvim/vsnip.vim;
                  };
                }];
              }
              {
                plugin = ddc-source-nvim-lsp;
                modules = [ "ddc_nvim_lsp" ];
              }
              {
                plugin = ddc-nvim-lsp-setup;
                config = readFile ./../nvim/ddc-nvim-lsp-setup.lua;
              }
              ddc-tmux
              # ddc-ui-native
              # denops-popup-preview-vim
              # {
              #   plugin = ddc-previewer-floating;
              #   config = readFile ./../nvim/ddc-previewer-floating.lua;
              #   depends = [ pum-vim ];
              # }
              denops-signature_help
              neco-vim
              # TODO lazy
              {
                plugin = ddc-source-nvim-obsidian;
                depends = [ obsidian-nvim ];
              }
              {
                plugin = tsnip-nvim;
                config = {
                  lang = "lua";
                  code = readFile ./../nvim/tsnip.lua;
                  args = { tsnip_root = ./../snippets/tsnip; };
                };
                depends = [ nui-nvim ];
              }
            ];
            depends = [
              denops-vim
              # {
              #   plugin = LuaSnip;
              #   config = {
              #     lang = "lua";
              #     code = readFile ./../nvim/luasnip.lua;
              #     args = { snipmate_root = ./../snippets/snipmate; };
              #   };
              #   depends = [ friendly-snippets ];
              # }
            ];
            dependBundles = [ "lsp" ];
            config = {
              lang = "vim";
              code = readFile ./../nvim/ddc.vim;
              args = { ts_config = ./../nvim/ddc.ts; };
            };
            lazy = true;
          }
          # {
          #   name = "ddu";
          #   plugins = [
          #     ddu-vim
          #     ddu-ui-ff
          #     ddu-source-file
          #     ddu-source-file_rec
          #     ddu-source-buffer
          #     {
          #       plugin = ddu-source-file_external;
          #       extraPackages = [ pkgs.fd ];
          #     }
          #     {
          #       plugin = ddu-source-rg;
          #       depends = [ kensaku-vim ];
          #       extraPackages = [ pkgs.ripgrep ];
          #     }
          #     ddu-filter-converter_display_word
          #     ddu-filter-matcher_substring
          #     ddu-filter-fzf
          #     ddu-kind-file
          #   ];
          #   depends = [ denops-vim ];
          #   config = {
          #     lang = "vim";
          #     code = readFile ./../nvim/ddu.vim;
          #   };
          #   # WIP
          #   lazy = true;
          #   commands = [ ];
          # }
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
              code = readFile ./../nvim/neotest.lua;
            };
            commands = [ "Neotest" ];
          }
        ];

    in {
      # programs.bundler-nvim = {
      #   enable = true;
      #   extraConfig = ''
      #     vim.cmd([[
      #       ${readFile ./../nvim/disable-default-plugin.vim}
      #       ${readFile ./../nvim/prelude.vim}
      #       ${readFile ./../nvim/keymap.vim}
      #     ]])
      #     vim.loader.enable()
      #     ${readFile ./../nvim/prelude.lua}
      #     ${readFile ./../nvim/keymap.lua}
      #     if vim.g.neovide then
      #       dofile("${./../nvim/neovide.lua}")
      #     end
      #   '';
      #   extraPackages = with pkgs; [ delta ];
      #   optPlugins = [ ] ++ ai ++ basic ++ motion ++ tool ++ git ++ lang ++ code
      #     ++ ui
      #
      #     ++ custom;
      #   inherit startPlugins bundles;
      # };
      # // optionalAttrs isDarwin {
      #   package = inputs.nifoc-overlay.packages.${system}.neovim-nightly;
      # };
    };
}
