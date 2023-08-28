require("neotest").setup({
  adapters = {
    require("neotest-jest")({
      jestConfigFile = "jest.config.js",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
    require("neotest-vim-test")({ allow_file_types = { "java" } }),
  },
  benchmark = {
    enabled = true,
  },
  consumers = {},
  default_strategy = "integrated",
  diagnostic = {
    enabled = true,
    severity = 1,
  },
  discovery = {
    concurrent = 0,
    enabled = true,
  },
  floating = {
    border = "single",
    max_height = 0.6,
    max_width = 0.6,
    options = {},
  },
  highlights = {
    adapter_name = "NeotestAdapterName",
    border = "NeotestBorder",
    dir = "NeotestDir",
    expand_marker = "NeotestExpandMarker",
    failed = "NeotestFailed",
    file = "NeotestFile",
    focused = "NeotestFocused",
    indent = "NeotestIndent",
    marked = "NeotestMarked",
    namespace = "NeotestNamespace",
    passed = "NeotestPassed",
    running = "NeotestRunning",
    select_win = "NeotestWinSelect",
    skipped = "NeotestSkipped",
    target = "NeotestTarget",
    test = "NeotestTest",
    unknown = "NeotestUnknown",
    watching = "NeotestWatching",
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "",
    running = "",
    running_animated = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    },
    skipped = "",
    unknown = "",
    watching = "",
  },
  jump = {
    enabled = true,
  },
  log_level = 3,
  output = {
    enabled = true,
    open_on_run = "short",
  },
  output_panel = {
    enabled = true,
    open = "botright split | resize 15",
  },
  projects = {},
  quickfix = {
    enabled = true,
    open = false,
  },
  run = {
    enabled = true,
  },
  running = {
    concurrent = true,
  },
  state = {
    enabled = true,
  },
  status = {
    enabled = true,
    signs = true,
    virtual_text = false,
  },
  strategies = {
    integrated = {
      height = 40,
      width = 120,
    },
  },
  summary = {
    animated = true,
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      attach = "a",
      clear_marked = "M",
      clear_target = "T",
      debug = "d",
      debug_marked = "D",
      expand = { "<CR>", "<2-LeftMouse>" },
      expand_all = "e",
      jumpto = "i",
      mark = "m",
      next_failed = "J",
      output = "o",
      prev_failed = "K",
      run = "r",
      run_marked = "R",
      short = "O",
      stop = "u",
      target = "t",
      watch = "w",
    },
    open = "botright vsplit | vertical resize 50",
  },
  watch = {
    enabled = true,
    symbol_queries = {},
  },
})

vim.api.nvim_create_user_command("Neotest", [[ lua require("neotest").run.run(vim.fn.expand("%")) ]], {})
vim.api.nvim_create_user_command("NeotestStop", [[ lua require("neotest").run.stop() ]], {})
vim.api.nvim_create_user_command("NeotestNearest", [[ lua require("neotest").run.run() ]], {})
vim.api.nvim_create_user_command("NeotestCurrentFile", [[ lua require("neotest").run.run(vim.fn.expand("%")) ]], {})
vim.api.nvim_create_user_command("NeotestAllFile", [[ lua require("neotest").run.run(vim.loop.cwd()) ]], {})
vim.api.nvim_create_user_command("NeotestToggleSummary", [[ lua require("neotest").summary.toggle() ]], {})
vim.api.nvim_create_user_command("NeotestTogglePanel", [[ lua require("neotest").output_panel.toggle() ]], {})
