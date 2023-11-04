vim.diagnostic.config({
  severity_sort = true,
})
vim.lsp.set_log_level("WARN")

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = "", numhl = "" })
end

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local on_attach = dofile(args.on_attach_path)
local capabilities = dofile(args.capabilities_path)
local eslint_cmd = args.eslint_cmd

require("lspconfig.ui.windows").default_options.border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }
-- lua
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- nix
lspconfig.nil_ls.setup({
  autostart = true,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})
-- lspconfig.nixd.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- bash
lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- csharp (use csharp_ls)
lspconfig.csharp_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- ruby
lspconfig.solargraph.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- toml
lspconfig.taplo.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- go
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
    },
    staticcheck = true,
  },
})

-- dart
lspconfig.dartls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- dhall
lspconfig.dhall_lsp_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- yaml
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
})

-- html
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- css, scss, less
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- eslint
lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = eslint_cmd,
})

-- typescript (vtsls)
lspconfig.vtsls.setup({
  single_file_support = false,
  root_dir = lspconfig.util.root_pattern("package.json"),
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    typescript = {
      suggest = {
        completeFunctionCalls = true,
      },
      preferences = {
        importModuleSpecifier = "relative",
      },
    },
    vtsls = {
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
})

-- fennel
-- lspconfig.fennel_language_server.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     fennel = {
--       workspace = {
--         library = vim.api.nvim_list_runtime_paths(),
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--     },
--   },
-- })
lspconfig.fennel_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})


-- rust
-- lspconfig.rust_analyzer.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     ["rust-analyzer"] = {
--       imports = {
--         granularity = {
--           group = "module",
--         },
--         prefix = "self",
--       },
--       cargo = {
--         buildScripts = {
--           enable = true,
--         },
--       },
--       procMacro = {
--         enable = true,
--       },
--     },
--   },
-- })
