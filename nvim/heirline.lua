local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local icons = {
  circle = "",
  circle_o = "⭘",
  circle_d = "",
  lock = "",
  left_rounded = "",
  left_rounded_thin = "",
  right_rounded = "",
  right_rounded_thin = "",
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
    hl = colors.red,
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
    hl = { bg = colors.bg },
    utils.surround({
      icons.left_rounded,
      icons.right_rounded,
    }, function(self) -- color
      return mode_colors[self.mode:sub(1, 1)]
    end, {
      {
        fallthrough = false,
        ReadOnlySymbol,
        { provider = icons.circle, hl = { fg = colors.bg } },
      },
      Space,
      {
        provider = function(self)
          return "%2(" .. self.mode_names[self.mode] .. "%)"
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

local DefaultStatusLine = {
  LeftCap,
  Mode,
}

local StatusLine = {
  fallthrough = false,
  DefaultStatusLine,
}

require("heirline").setup({
  statusline = StatusLine,
  opts = {
    colors = colors,
  },
})
