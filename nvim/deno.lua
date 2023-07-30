local on_attach = dofile(args.on_attach_path)
local capabilities = dofile(args.capabilities_path)
local node_root_dir = require("lspconfig").util.root_pattern("package.json")
local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

if not is_node_repo then
  require("deno-nvim").setup({
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        deno = {
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
            parameterTypes = {
              enabled = true,
            },
            variableTypes = {
              enabled = true,
            },
            propertyDeclarationTypes = {
              enabled = true,
            },
            functionLikeReturnTypes = {
              enabled = true,
            },
            enumMemberValues = {
              enabled = true,
            },
          },
        },
      },
    },
  })
  vim.cmd([[LspStart]])
end
