local rt = require("rust-tools")
rt.setup({
  tools = {
    executor = require("rust-tools.executors").toggleterm,
    on_initialized = nil,
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      -- use lsp-inlayhints.nvim
      auto = false,
    },
    hover_actions = {
      border = {
        { "┏", "FloatBorder" },
        { "━", "FloatBorder" },
        { "┓", "FloatBorder" },
        { "┃", "FloatBorder" },
        { "┛", "FloatBorder" },
        { "━", "FloatBorder" },
        { "┗", "FloatBorder" },
        { "┃", "FloatBorder" },
      },
      max_width = nil,
      max_height = nil,
      auto_focus = false,
    },
  },
  server = {
    on_attach = dofile(args.on_attach_path),
    capabilities = dofile(args.capabilities_path),
    settings = {
      ["rust-analyzer"] = {
        assist = {
          expressionFillDefault = "todo",
        },
        cachePriming = {
          enable = true,
          numThreads = 0, -- auto
        },
        cargo = {
          autoreload = true,
          buildScripts = {
            enable = true,
            useRustcWrapper = true,
            noSysroot = false,
            unsetTest = { "core" },
          },
        },
        check = {
          allTargets = true,
          checkOnSave = true,
          extraArgs = {},
        },
        completion = {
          autoimport = {
            enable = true,
          },
          autoself = {
            enable = true,
          },
          callable = {
            snippets = "fill_arguments",
          },
          postfix = {
            enable = true,
          },
          privateEditable = {
            enable = false,
          },
        },
        diagnostics = {
          enable = true,
          disabled = {},
          experimental = {
            enable = false,
          },
          remapPrefix = {},
          warningsAsHint = {},
          warningsAsInfo = {},
        },
        files = {
          excludeDirs = {},
          watcher = "client", -- "client" | "server"
        },
        highlightRelated = {
          breakPoints = {
            enable = true,
          },
          exitPoints = {
            enable = true,
          },
          references = {
            enable = true,
          },
          yieldPoints = {
            enable = true,
          },
        },
        hover = {
          actions = {
            enable = true,
            debug = {
              enable = true,
            },
            gotoTypeDef = {
              enable = true,
            },
            implementations = {
              enable = true,
            },
            references = {
              enable = true,
            },
            run = {
              enable = true,
            },
          },
          documentation = {
            enable = true,
          },
          links = {
            enable = true,
          },
        },
        imports = {
          granularity = {
            enforce = false, -- keep current style
            group = "crate", -- "preserve" | "crate" | "module" | "item"
          },
          group = {
            enable = true,
          },
          merge = {
            glob = true,
          },
          prefix = "plain", -- "plain" | "self" | "crate"
        },
        -- inlayHints = {
        -- 	bindingModeHints = {
        -- 		enable = false,
        -- 	},
        -- 	chainingHints = {
        -- 		enable = true,
        -- 	},
        -- 	closingBraceHints = {
        -- 		enable = true,
        -- 		minLines = 25,
        -- 	},
        -- 	closureReturnTypeHints = {
        -- 		enable = "never", -- "always" | "with_block" | "never"
        -- 	},
        -- 	lifetimeElisionHints = {
        -- 		enable = "never", -- "always" | "skip_trivial" | "never"
        -- 		useParameterNames = true,
        -- 	},
        -- 	maxLength = 25,
        -- 	reborrowHints=  {
        -- 		enable = "mutable", -- "always" | "mutable" | "never"
        -- 	},
        -- 	renderColons = true,
        -- 	typeHints = {
        -- 		enable = true,
        -- 		hideClosureInitialization = false,
        -- 		hideNamedConstructor = false,
        -- 	},
        -- }
        joinLines = {
          joinAssignments = true,
          joinElseIf = true,
          removeTrailingComma = true,
          unwrapTrivialBlock = true,
        },
        lens = {
          enable = true,
          debug = {
            enable = true,
          },
          forceCustomCommands = true,
          implementations = {
            enable = true,
          },
          references = {
            atd = {
              enable = false,
            },
            enumVariant = {
              enable = false,
            },
            method = {
              enable = false,
            },
            trait = {
              enable = false,
            },
            run = {
              enable = true,
            },
          },
        },
        linkedProjects = {},
        notifications = {
          cargoTomlNotFound = true,
        },
        procMacro = {
          enable = true,
          attributes = {
            enable = true,
          },
          ignored = {},
        },
        runnables = {
          extraArgs = {},
        },
        rustfmt = {
          extraArgs = {},
          rangeFormatting = {
            enable = false,
          },
        },
        semanticHighlighting = {
          strings = {
            enable = true,
          },
        },
        signatureInfo = {
          detail = "full",
          documentation = {
            enable = true,
          },
        },
        typing = {
          autoClosingAngleBrackets = {
            enable = false,
          },
        },
        workspace = {
          symbol = {
            search = {
              kind = "only_types", -- "only_types" | "all_symbols"
              limit = 128,
              scope = "workspace", -- "workspace" | "workspace_and_dependencies"
            },
          },
        },
      },
    },
  },
})

vim.cmd([[LspStart]])
