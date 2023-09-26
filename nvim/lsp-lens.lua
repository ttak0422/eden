require("lsp-lens").setup({
  enable = false,
  include_declaration = false,
  sections = {
    definition = false,
    references = true,
    implementation = true,
  },
  ignore_filetype = {
    "prisma",
  },
})
