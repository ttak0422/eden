local circles = require("circles")
circles.setup({ icons = { empty = "", filled = "", lsp_prefix = "" } })

local function on_attach(bufnr)
  local map = vim.keymap.set
  local function opts(desc)
    return { desc = "[nvim-tree] " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  local api = require("nvim-tree.api")
  map("n", "K", api.node.show_info_popup, opts("show file info"))
  map("n", "a", api.fs.create, opts("create new file"))
  map("n", "r", api.fs.rename, opts("rename file"))
  map("n", "d", api.fs.remove, opts("delete file"))
  map("n", "o", api.node.open.edit, opts("edit file"))
  map("n", "<CR>", api.node.open.edit, opts("edit file"))
  map("n", "<C-v>", api.node.open.vertical, opts("edit file (vertical)"))
  map("n", "<C-s>", api.node.open.horizontal, opts("edit file (horizontal)"))
  map("n", "R", api.tree.reload, opts("reflesh tree"))
  map("n", "?", api.tree.toggle_help, opts("show help"))
  map("n", "[c", api.node.navigate.git.prev, opts("prev git"))
  map("n", "]c", api.node.navigate.git.next, opts("next git"))
  map("n", "[d", api.node.navigate.diagnostics.prev, opts("prev diagnostics"))
  map("n", "]d", api.node.navigate.diagnostics.next, opts("next diagnostics"))
end

require("nvim-tree").setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    width = 35,
    side = "left",
    adaptive_size = false,
    mappings = {
      custom_only = true,
    },
  },
  on_attach = on_attach,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  renderer = {
    root_folder_label = false,
    group_empty = true,
    indent_width = 1,
    icons = {
      glyphs = circles.get_nvimtree_glyphs(),
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
})
