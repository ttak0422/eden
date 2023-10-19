local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                                               ]],
  [[                                               ]],
  [[    ██████████████ ███████████   ██   ]],
  [[   ██     ██  ████     █████  ██    ]],
  [[  █████████  ██████████████ ██     ]],
  [[ ██     ██  ████     ██ █████      ]],
  [[████████████████████████  █████       ]],
  [[                                               ]],
  [[                                               ]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("q", "  Quit Nvim", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
