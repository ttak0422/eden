vim.g.mapleader = " "

local key_opts = { noremap = true, silent = true }
local function desc(d)
  return { noremap = true, silent = true, desc = d }
end
local function cmd(c)
  return "<cmd>" .. c .. "<cr>"
end

local function lua(c)
  return cmd("lua " .. c)
end

local function toggle_tool()
  local is_open = false
  local pre_id = nil
  return function(id, mod, opt)
    return function()
      local t = require("toolwindow")
      if pre_id ~= id then
        t.open_window(mod, opt)
        is_open = true
      else
        if is_open then
          t.close()
          is_open = false
        else
          t.open_window(mod, opt)
          is_open = true
        end
      end
      pre_id = id
    end
  end
end
local toggle = toggle_tool()
local map = vim.keymap.set

local normal_keymaps = {
  -- utils
  { "<esc><esc>", cmd("nohl") },
  { "q", "<nop>" },
  { "j", "gj" },
  { "k", "gk" },
  { "<c-w>q", cmd("SafeCloseWindow") },
  { "<c-w><c-q>", cmd("SafeCloseWindow") },
  -- { "<leader>g", "<cmd>JABSOpen<cr>" },
  -- split/join
  { "<leader>m", cmd("lua require('treesj').toggle()"), desc("toggle split/join") },
  {
    "<leader>M",
    cmd("lua require('treesj').toggle({ split = { recursive = true } })"),
    desc("toggle split/join rec"),
  },
  -- motion
  {
    "<c-w><c-w>",
    cmd("lua require('nvim-window').pick()"),
    desc("choose window"),
  },
  {
    "gpd",
    cmd("lua require('goto-preview').goto_preview_definition()"),
    desc("preview definition"),
  },
  {
    "gpi",
    cmd("lua require('goto-preview').goto_preview_implementation()"),
    desc("preview implementation"),
  },
  {
    "gpr",
    cmd("lua require('goto-preview').goto_preview_references()"),
    desc("preview references"),
  },
  {
    "gP",
    cmd("lua require('goto-preview').close_all_win()"),
    desc("close all preview"),
  },
  -- git
  {
    "<leader>gg",
    function()
      vim.cmd("Gin " .. vim.fn.input("git command: "))
    end,
    desc("git command (echo)"),
  },
  {
    "<leader>gG",
    function()
      vim.cmd("GinBuffer " .. vim.fn.input("git command: "))
    end,
    desc("git command (buffer)"),
  },
  {
    "<leader>gB",
    cmd("Gina blame"),
    desc("git blame"),
  },
  {
    "<leader>gs",
    cmd("GinStatus"),
    desc("git status"),
  },
  {
    "<leader>gl",
    cmd("GinLog"),
    desc("git log"),
  },
  {
    "<leader>G",
    cmd("Neogit"),
    desc("open git tui"),
  },
  -- window
  { "<c-w>z", cmd("NeoZoomToggle") },
  { "<c-w>e", cmd("lua require('smart-splits').start_resize_mode()"), desc("window resize mode") },
  -- tools
  { "<leader>q", cmd("BufDel") },
  { "<leader>Q", cmd("BufDel!") },
  { "<leader>E", cmd("FeMaco"), desc("edit code block") },
  -- buffer
  { "<leader>br", lua([[require("harpoon.mark").add_file()]]), desc("register buffer (harpoon)") },
  -- toggle
  { "<leader>tc", cmd("ColorizerToggle"), desc("toggle colorize") },
  { "<leader>tb", cmd("NvimTreeToggle") },
  { "<leader>to", cmd("SidebarNvimToggle") },
  -- { "<leader>tb", cmd("Neotree toggle") },
  { "<leader>tq", toggle(1, "quickfix", nil), desc("open quickfix") },
  {
    "<leader>td",
    toggle(2, "trouble", { mode = "document_diagnostics" }),
    desc("open diagnostics (document)"),
  },
  {
    "<leader>tD",
    toggle(3, "trouble", { mode = "workspace_diagnostics" }),
    desc("open diagnostics (workspace)"),
  },
  {
    "<leader>tm",
    cmd("lua require('codewindow').toggle_minimap()"),
    desc("open minimap"),
  },
  {
    "<leader>tr",
    cmd("lua require('harpoon.ui').toggle_quick_menu()"),
    desc("open registered buffer menu (harpoon)"),
  },
  -- finder
  { "<leader>ff", cmd("Telescope live_grep_args"), desc("search by content") },
  { "<leader>fp", cmd("Ddu -name=fd file_fd"), desc("search by file name") },
  { "<leader>fP", cmd("Ddu -name=ghq ghq"), desc("search repo (ghq)") },
  { "<leader>fb", cmd("Telescope buffers"), desc("search buffer") },
  { "<leader>fh", cmd("Legendary"), desc("search legendary") },
  { "<leader>ft", cmd("Telescope sonictemplate templates"), desc("search template") },
  { "<leader>fru", cmd("Ddu -name=mru mru"), desc("MRU (Most Recently Used files)") },
  { "<leader>frw", cmd("Ddu -name=mrw mrw"), desc("MRW (Most Recently Written files)") },
  { "<leader>frr", cmd("Ddu -name=mrr mrr"), desc("MRR (Most Recent git Repositories)") },
  {
    "<leader>fF",
    cmd("lua require('spectre').open()"),
    desc("find and replace with dark power"),
  },
  -- obsidian
  { "<leader>oo", cmd("ObsidianFollowLink") },
  { "<leader>oO", cmd("ObsidianOpen") },
  { "<leader>or", cmd("ObsidianBacklinks") },
  { "<leader>ot", cmd("ObsidianToday") },
  { "<leader>of", cmd("ObsidianSearch") },
  { "<leader>op", cmd("ObsidianQuickSwitch") },
  {
    "<leader>on",
    function()
      vim.cmd("ObsidianNew " .. vim.fn.input("name: "))
    end,
    desc("create new note"),
  },
  -- neorg
  { "<leader>nn", cmd("Neorg index") },
  { "<leader>nt", cmd("Neorg journal today"), desc("neorg today") },
  { "<leader>ny", cmd("Neorg journal yesterday"), desc("neorg today") },
}

for _, keymap in ipairs(normal_keymaps) do
  map("n", keymap[1], keymap[2], keymap[3] or key_opts)
end

-- for _, key in ipairs({ "w", "e", "b" }) do
--   map("n", key, cmd("lua require('spider').motion('" .. key .. "')"))
-- end

-- toggle term
for i = 0, 9 do
  map({ "n", "t", "i" }, "<C-" .. i .. ">", cmd("TermToggle " .. i), desc("toggle terminal " .. i))
end
map("n", "<leader>tg", cmd("TigTermToggle"), desc("toggle tig terminal "))

map({ "n", "x" }, "gs", "<cmd>lua require('reacher').start()<cr>", desc("search displayed"))
map({ "n", "x" }, "gS", "<cmd>lua require('reacher').start_multiple()<cr>", desc("search displayed"))
