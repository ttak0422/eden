-- [nfnl] Compiled from nvim/fnl/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local is_direnv = false
local is_direnv_active = false
local check_direnv
local function _1_()
  local function _2_(_, code, _0)
    is_direnv = (code == 0)
    return nil
  end
  return vim.loop.spawn("sh", {args = {"-c", "direnv status | grep --silent 'Found RC allowed'"}, stdio = {nil, nil, nil}}, _2_)
end
check_direnv = _1_
local check_direnv_active
local function _3_()
  local function _4_(_, code, _0)
    is_direnv_active = (code == 0)
    return nil
  end
  return vim.loop.spawn("sh", {args = {"-c", "direnv status | grep --silent 'Found RC allowed true'"}, stdio = {nil, nil, nil}}, _4_)
end
check_direnv_active = _3_
local function _5_()
  check_direnv()
  check_direnv_active()
  return vim.cmd("redrawstatus")
end
vim.api.nvim_create_autocmd({"DirChanged"}, {pattern = "*", callback = _5_})
local ignore_lsp = {copilot = true}
local check_lsp_attach
local function _6_()
  local clients = vim.lsp.get_active_clients({bufnr = 0})
  local acc = false
  for _, client in pairs(clients) do
    acc = (acc or not ignore_lsp[client.name])
  end
  return acc
end
check_lsp_attach = _6_
local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local kanagawa = require("kanagawa.colors")
local hydra = require("hydra.statusline")
local kanagawa_palette = kanagawa.setup().palette
local kanagawa_colors = {bg = kanagawa_palette.sumiInk2, fg = kanagawa_palette.sumiInk6, red = kanagawa_palette.autumnRed, green = kanagawa_palette.autumnGreen, blue = kanagawa_palette.winterBlue, grey = kanagawa_palette.fujiGray, orange = kanagawa_palette.surimiOrange, purple = kanagawa_palette.oniViolet, cyan = kanagawa_palette.lotusCyan, diag_warn = kanagawa_palette.roninYellow, diag_error = kanagawa_palette.samuraiRed, diag_hint = kanagawa_palette.dragonBlue, diag_info = kanagawa_palette.waveAqua1, git_del = kanagawa_palette.autumnRed, git_add = kanagawa_palette.autumnGreen, git_change = kanagawa_palette.autumnYellow}
local colors = kanagawa_colors
local opts = {colors = colors}
local icons = {terminal = "\239\146\137", keyboard = "\239\132\156 ", vim = "\238\152\171", circle = "\239\132\145", circle_o = "\226\173\152", circle_d = "\239\134\146", lock = "\239\128\163", left_rounded = "\238\130\182", left_rounded_thin = "\238\130\183", right_rounded = "\238\130\180", right_rounded_thin = "\238\130\181", bar = "|", warn = "\239\129\177", error = "\239\129\151", document = "\239\133\155"}
local seps = {bar = (" " .. icons.bar .. " "), left_rounded_thin = (" " .. icons.left_rounded_thin .. " "), right_rounded_thin = (" " .. icons.right_rounded_thin .. " ")}
local mode_labels = {n = "N", no = "N", nov = "N", noV = "N", ["no\22"] = "N", niI = "N", niR = "N", niV = "N", nt = "N", v = "V", vs = "V", V = "V", Vs = "V", ["\22"] = "V", ["\22s"] = "V", s = "S", S = "S", ["\19"] = "S", i = "I", ic = "I", ix = "I", R = "R", Rc = "R", Rx = "R", Rv = "R", Rvc = "R", Rvx = "R", c = "C", ct = "C", cv = "Ex", ce = "C", r = "...", rm = "M", ["r?"] = "?", ["!"] = "!", t = "T"}
local mode_colors = {n = "red", no = "red", nov = "red", noV = "red", ["no\22"] = "red", niI = "red", niR = "red", niV = "red", nt = "red", v = "blue", vs = "blue", V = "blue", Vs = "blue", ["\22"] = "blue", ["\22s"] = "blue", s = "purple", S = "purple", ["\19"] = "purple", i = "green", ic = "green", ix = "green", R = "orange", Rc = "orange", Rx = "orange", Rv = "orange", Rvc = "orange", Rvx = "orange", c = "red", ct = "red", cv = "red", ce = "red", r = "red", rm = "red", ["r?"] = "red", ["!"] = "red", t = "red"}
local skk_mode_labels = {[""] = "\232\139\177\230\149\176", hira = "\227\129\178\227\130\137", kata = "\227\130\171\227\131\138", hankata = "\229\141\138\227\130\171", zenkaku = "\229\133\168\232\139\177", abbrev = "abbr"}
local align = {provider = "%="}
local left_cap = {provider = "\226\150\140"}
local space = {provider = " "}
local bar = {provider = seps.bar}
local round_right = {provider = seps.right_rounded_thin}
local mode
do
  local readonly_symbol
  local function _7_()
    return (not vim.bo.modifiable or vim.bo.readonly)
  end
  readonly_symbol = {condition = _7_, provider = (icons.lock .. " "), hl = {fg = colors.bg}}
  local vim_symbol = {provider = (icons.vim .. " "), hl = {fg = colors.bg}}
  local symbol = {readonly_symbol, vim_symbol, fallthrough = false}
  local mode_vim
  local function _8_(self)
    return ((mode_labels[(self.mode):sub(1, 1)] or (self.mode):sub(1, 1)) .. " | ")
  end
  local function _9_(self)
    return {fg = colors.bg, bg = mode_colors[self.mode]}
  end
  mode_vim = {provider = _8_, hl = _9_}
  local mode_skk
  local function _10_(self)
    self.skk_mode = (vim.fn["skkeleton#mode"]() or "")
    return nil
  end
  local function _11_(self)
    return (skk_mode_labels[self.skk_mode] or self.skk_mode)
  end
  mode_skk = {init = _10_, provider = _11_, hl = {fg = colors.bg}}
  local function _12_(self)
    return mode_colors[(self.mode):sub(1, 1)]
  end
  local function _13_(self)
    self.mode = vim.fn.mode(1)
    return nil
  end
  mode = {utils.surround({icons.left_rounded, icons.right_rounded}, _12_, {symbol, mode_vim, mode_skk}), init = _13_, update = {"ModeChanged"}}
end
local git
do
  local active
  local function _14_(self)
    return ("\239\144\152 " .. self.git_status.head)
  end
  local function _15_(self)
    return (" \239\145\151 " .. (self.git_status.added or 0))
  end
  local function _16_(self)
    return (" \239\145\153 " .. (self.git_status.changed or 0))
  end
  local function _17_(self)
    return (" \239\145\152 " .. (self.git_status.removed or 0))
  end
  local function _18_(self)
    self.git_status = vim.b.gitsigns_status_dict
    return nil
  end
  active = {{provider = _14_}, {{provider = _15_, hl = {fg = colors.git_add}}, {provider = _16_, hl = {fg = colors.git_change}}, {provider = _17_, hl = {fg = colors.git_del}}}, condition = conditions.is_git_repo, init = _18_}
  local inactive = {{provider = "\239\144\152 ------"}, {{provider = " \239\145\151 - \239\145\153 - \239\145\152 -"}}}
  git = {active, inactive, fallthrough = false}
end
local diagnostics
do
  local active
  local function _19_(self)
    self.errors = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
    self.warns = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
    return nil
  end
  local function _20_()
    return (require("trouble")).toggle({mode = "document_diagnostics"})
  end
  local function _21_(self)
    return (icons.error .. " " .. self.errors .. " " .. icons.warn .. " " .. self.warns)
  end
  active = {condition = conditions.has_diagnostics, init = _19_, on_click = {callback = _20_, name = "heirline_diagnostics"}, provider = _21_}
  local inactive = {provider = (icons.error .. " - " .. icons.warn .. " -")}
  diagnostics = {active, inactive, fallthrough = false}
end
local pomodoro
local function _22_()
  return (require("piccolo-pomodoro")).status()
end
local function _23_()
  return (require("piccolo-pomodoro")).toggle()
end
pomodoro = {provider = _22_, on_click = {callback = _23_, name = "toggle_pomodoro"}}
local search_count
local function _24_()
  return ((vim.v.hlsearch ~= 0) and (vim.o.cmdheight == 0))
end
local function _25_(self)
  local ok, search = pcall(vim.fn.searchcount)
  if (ok and search.total) then
    self.search = search
    return nil
  else
    return nil
  end
end
local function _27_(self)
  return string.format("[%d/%d]", self.search.current, math.min(self.search.total, self.search.maxcount))
end
search_count = {condition = _24_, init = _25_, provider = _27_}
local ruler = {provider = "%7(%l,%c%)"}
local file_properties
do
  local encoding
  local function _28_(self)
    self.encoding = (((vim.bo.fileencoding ~= "") and vim.bo.fileencoding) or vim.o.encoding or nil)
    return self.encoding
  end
  local function _29_(self)
    return (self.encoding_label[self.encoding] or self.encoding)
  end
  encoding = {condition = _28_, provider = _29_, static = {encoding_label = {["utf-8"] = "UTF-8"}}}
  local format
  local function _30_(self)
    self.format = vim.bo.fileformat
    return self.format
  end
  local function _31_(self)
    return (self.format_label[self.format] or self.format)
  end
  format = {condition = _30_, provider = _31_, static = {format_label = {dos = "CRLF", mac = "CR", unix = "LF"}}}
  file_properties = {encoding, space, format, update = {"WinNew", "WinClosed", "BufEnter"}}
end
local indicator
do
  local direnv
  local function _32_()
    if is_direnv_active then
      return "\239\136\133  direnv "
    else
      return "\239\136\132  direnv "
    end
  end
  direnv = {provider = _32_}
  local lsp
  local function _34_(self)
    if self.lsp_active then
      return "\239\136\133  LSP "
    else
      return "\239\136\132  LSP "
    end
  end
  lsp = {provider = _34_, update = {"LspAttach", "LspDetach"}}
  local function _36_(self)
    self.lsp_active = check_lsp_attach()
    return (self.lsp_active or is_direnv)
  end
  local function _37_()
    local function _38_()
      return vim.cmd("LspInfo")
    end
    return vim.defer_fn(_38_, 100)
  end
  indicator = {lsp, direnv, condition = _36_, on_click = {callback = _37_, name = "heirline_lsp"}}
end
local root
do
  local function _39_(self)
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    self.root = (self.alias[cwd] or cwd)
    return nil
  end
  local function _40_(self)
    return (" \239\132\161  %4(" .. self.root .. "%) ")
  end
  root = {init = _39_, provider = _40_, update = {"DirChanged"}, hl = {fg = colors.bg, bg = colors.orange}, static = {alias = {[""] = "ROOT"}}}
end
local default_status_line = {left_cap, mode, space, git, round_right, diagnostics, round_right, pomodoro, align, search_count, align, ruler, bar, file_properties, bar, indicator, root}
local statusline = {default_status_line, hl = {fg = colors.fg, bg = colors.bg, bold = true}, fallthrough = false}
return heirline.setup({statusline = statusline, opts = opts})
