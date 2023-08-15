local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local icons = {
  vim = "",
  circle = "",
  circle_o = "⭘",
  circle_d = "",
  lock = "",
  left_rounded = "",
  left_rounded_thin = "",
  right_rounded = "",
  right_rounded_thin = "",
  bar = "|",
}

local everforest = {
  bg = utils.get_highlight("Folded").bg,
  fg = utils.get_highlight("Folded").fg,
  red = utils.get_highlight("red").fg,
  green = utils.get_highlight("green").fg,
  blue = utils.get_highlight("blue").fg,
  grey = utils.get_highlight("grey").fg,
  orange = utils.get_highlight("orange").fg,
  purple = utils.get_highlight("purple").fg,
  cyan = utils.get_highlight("aqua").fg,
  diag_warn = utils.get_highlight("WarningText").fg,
  diag_error = utils.get_highlight("ErrorText").fg,
  diag_hint = utils.get_highlight("HintText").fg,
  diag_info = utils.get_highlight("InfoText").fg,
  git_del = utils.get_highlight("DiffDelete").fg,
  git_add = utils.get_highlight("DiffAdd").fg,
  git_change = utils.get_highlight("DiffChange").fg,
}
local colors = everforest

local mode_colors = {
  n = "red",
  i = "green",
  v = "blue",
  V = "blue",
  ["\22"] = "blue",
  c = "orange",
  s = "purple",
  S = "purple",
  ["\19"] = "purple",
  R = "orange",
  r = "orange",
  ["!"] = "red",
  t = "red",
}

--                                                   _
--   ___ ___  _ __ ___  _ __   ___  _ __   ___ _ __ | |_
--  / __/ _ \| '_ ` _ \| '_ \ / _ \| '_ \ / _ \ '_ \| __|
-- | (_| (_) | | | | | | |_) | (_) | | | |  __/ | | | |_
--  \___\___/|_| |_| |_| .__/ \___/|_| |_|\___|_| |_|\__|
--                     |_|
local Align = { provider = "%=" }
local Space = { provider = " " }
local LeftCap = { provider = "▌" }
local Mode
do
  local ReadOnlySymbol = {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = icons.lock,
    hl = { fg = colors.bg },
  }
  local NormalModeIndicator = {
    Space,
    {
      fallthrough = false,
      ReadOnlySymbol,
      { provider = icons.circle },
    },
    Space,
  }
  local ActiveModeIndicator = {
    condition = function(self)
      return self.mode ~= "normal"
    end,
    utils.surround({
      icons.left_rounded,
      icons.right_rounded,
    }, function(self) -- color
      return mode_colors[self.mode:sub(1, 1)]
    end, {
      {
        fallthrough = false,
        ReadOnlySymbol,
        { provider = icons.vim, hl = { fg = colors.bg } },
      },
      {
        provider = function(self)
          return "%2(" .. self.mode_names[self.mode] .. "%)"
        end,
        hl = function(self)
          return {
            fg = colors.bg,
            bg = mode_colors[self.mode:sub(1, 1)],
            bold = true,
          }
        end,
      },
    }),
  }
  Mode = {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    condition = function()
      return vim.bo.buftype == ""
    end,
    static = {
      mode_names = {
        n = "N",
        no = "N?",
        nov = "N?",
        noV = "N?",
        ["no\22"] = "N?",
        niI = "Ni",
        niR = "Nr",
        niV = "Nv",
        nt = "Nt",
        v = "v",
        vs = "Vs",
        V = "V",
        Vs = "Vs",
        ["\22"] = "^V",
        ["\22s"] = "^V",
        s = "S",
        S = "S_",
        ["\19"] = "^S",
        i = "I",
        ic = "Ic",
        ix = "Ix",
        R = "R",
        Rc = "Rc",
        Rx = "Rx",
        Rv = "Rv",
        Rvc = "Rv",
        Rvx = "Rv",
        c = "C",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
      },
    },
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
    {
      fallthrough = false,
      ActiveModeIndicator,
      NormalModeIndicator,
    },
  }
end

local Git
do
  local GitBranch = {
    provider = function(self)
      return table.concat({ " ", self.git_status.head })
    end,
  }
  local GitChanges = {
    {
      provider = function(self)
        return "  " .. self.git_status.added
      end,
      hl = { fg = colors.git_add },
    },
    {
      provider = function(self)
        return "  " .. self.git_status.changed
      end,
      hl = { fg = colors.git_change },
    },
    {
      provider = function(self)
        return "  " .. self.git_status.removed
      end,
      hl = { fg = colors.git_del },
    },
  }
  Git = {
    condition = conditions.is_git_repo,
    init = function(self)
      self.git_status = vim.b.gitsigns_status_dict
    end,
    GitBranch,
    GitChanges,
  }
end

local Ruler = {
  provider = "%7(%l,%c%)",
  hl = { bold = true },
}

local Skk
do
  local SkkL = {
    provider = icons.bar,
  }
  Skk = {
    SkkL,
    {
      provider = function(self)
        local mode = vim.fn["skkeleton#mode"]() or ""
        return " SKK " .. self.mode_label[mode]
      end,
      hl = { bold = true },
      static = {
        mode_label = {
          [""] = "英数",
          ["hira"] = "ひら",
          ["kata"] = "カナ",
          ["hankata"] = "半カ",
          ["zenkaku"] = "全英",
          ["abbrev"] = "abbr",
        },
      },
      -- configured in skkeleton
      -- update = {},
    },
  }
end

local ProjectRoot
do
  local fg = colors.bg
  local bg = colors.orange
  local Root = {
    init = function(self)
      self.root = vim.fn["fnamemodify"](vim.fn["getcwd"](), ":t")
    end,
    provider = function(self)
      return "   %4(" .. self.root .. "%) "
    end,
    hl = { fg = fg, bg = bg, bold = true },
  }
  ProjectRoot = {
    Root,
  }
end

local DefaultStatusLine = {
  LeftCap,
  Mode,
  Space,
  Git,
  Space,
  Align,
  Ruler,
  Space,
  Skk,
  Space,
  ProjectRoot,
}

local StatusLine = {
  fallthrough = false,
  hl = { fg = colors.fg, bg = colors.bg },
  DefaultStatusLine,
}

require("heirline").setup({
  statusline = StatusLine,
  opts = {
    colors = colors,
  },
})
