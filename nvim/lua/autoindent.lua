-- [nfnl] Compiled from nvim/fnl/autoindent.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(lnum)
  return require["nvim-treesitter.indent"]("get_indent")(lnum)
end
return (require("auto-indent")).setup({lightmode = true, indentexpr = _1_, ignore_filetype = {}})
