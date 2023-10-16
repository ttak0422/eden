local diagnostic_wrn_opts = { severity = { min = vim.diagnostic.severity.WARN }, float = false }
local diagnostic_err_opts = { severity = { min = vim.diagnostic.severity.ERROR }, float = false }
local function cmd(c)
  return "<cmd>" .. c .. "<cr>"
end

local function get_qflist_nr(nr)
  return vim.fn["getqflist"]({ ["nr"] = nr }).nr
end

local function safe_qf_colder()
  local idx = get_qflist_nr(0)
  if 1 < idx then
    vim.cmd("silent colder")
  else
    local last_idx = get_qflist_nr("$")
    vim.cmd("silent " .. last_idx .. "chistory")
  end
end

local function safe_qf_cnewer()
  local idx = get_qflist_nr(0)
  local last_idx = get_qflist_nr("$")
  if idx < last_idx then
    vim.cmd("silent cnewer")
  else
    vim.cmd("silent 1chistory")
  end
end

require("nap").setup({
  next_prefix = "]",
  prev_prefix = "[",
  next_repeat = "<c-n>",
  prev_repeat = "<c-p>",
  operators = {
    ["b"] = {
      prev = { rhs = cmd("bprevious"), opts = { desc = "prev buffer" } },
      next = { rhs = cmd("bnext"), opts = { desc = "next buffer" } },
    },
    ["B"] = {
      prev = { rhs = "<Plug>(buf-surf-back)", opts = { desc = "prev buffer (history)" } },
      next = { rhs = "<Plug>(buf-surf-forward)", opts = { desc = "next buffer (history)" } },
    },
    ["r"] = {
      prev = {
        rhs = cmd([[lua require("harpoon.ui").nav_prev()]]),
        opts = { desc = "prev registered buffer (harpoon)" },
      },
      next = {
        rhs = cmd([[lua require("harpoon.ui").nav_next()]]),
        opts = { desc = "next registered buffer (harpoon)" },
      },
    },
    ["e"] = {
      prev = { rhs = "g,", opts = { desc = "prev change item" } },
      next = { rhs = "g;", opts = { desc = "next change item" } },
    },
    ["d"] = {
      prev = {
        rhs = function()
          vim.diagnostic.goto_prev(diagnostic_wrn_opts)
        end,
        opts = { desc = "prev warn" },
      },
      next = {
        rhs = function()
          vim.diagnostic.goto_next(diagnostic_wrn_opts)
        end,
        opts = { desc = "next warn" },
      },
      mode = { "n", "v", "o" },
    },
    ["D"] = {
      prev = {
        rhs = function()
          vim.diagnostic.goto_prev(diagnostic_err_opts)
        end,
        opts = { desc = "prev error" },
      },
      next = {
        rhs = function()
          vim.diagnostic.goto_next(diagnostic_err_opts)
        end,
        opts = { desc = "next error" },
      },
      mode = { "n", "v", "o" },
    },
    ["q"] = {
      -- prev = { rhs = cmd("Qprev"), opts = { desc = "prev quickfix" } },
      -- next = { rhs = cmd("Qnext"), opts = { desc = "next quickfix" } },
      prev = { rhs = cmd("cprev"), opts = { desc = "prev quickfix" } },
      next = { rhs = cmd("cnext"), opts = { desc = "next quickfix" } },
    },
    ["Q"] = {
      prev = { rhs = cmd("cfirst"), opts = { desc = "first quickfix" } },
      next = { rhs = cmd("clast"), opts = { desc = "last quickfix" } },
    },
    ["<C-q>"] = {
      prev = { rhs = cmd("cpfile"), opts = { desc = "prev quickfix item in different file" } },
      next = { rhs = cmd("cnfile"), opts = { desc = "next quickfix item in different file" } },
    },
    ["<M-q>"] = {
      prev = { rhs = safe_qf_colder, opts = { desc = "prev error list" } },
      next = { rhs = safe_qf_cnewer, opts = { desc = "next error list" } },
    },
    ["l"] = {
      prev = { rhs = cmd("Lprev"), opts = { desc = "prev loclist item" } },
      next = { rhs = cmd("Lnext"), opts = { desc = "next loclist item" } },
    },
    ["L"] = {
      prev = { rhs = cmd("lfirst"), opts = { desc = "first loclist item" } },
      next = { rhs = cmd("llast"), opts = { desc = "last loclist item" } },
    },
    ["<C-l>"] = {
      prev = { rhs = cmd("lpfile"), opts = { desc = "prev loclist item in different file" } },
      next = { rhs = cmd("lnfile"), opts = { desc = "next loclist item in different file" } },
    },
    ["<M-l>"] = {
      prev = { rhs = cmd("lolder"), opts = { desc = "prev loclist list" } },
      next = { rhs = cmd("lnewer"), opts = { desc = "next loclist list" } },
    },
  },
})
