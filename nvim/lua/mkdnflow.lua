-- [nfnl] Compiled from nvim/fnl/mkdnflow.fnl by https://github.com/Olical/nfnl, do not edit.
local mkdnflow = require("mkdnflow")
local modules = {conceal = true, cursor = true, links = true, lists = true, maps = true, paths = true, tables = true, yaml = false, bib = false, cmp = false, buffers = false, folds = false}
local filetypes = {md = true, rmd = true, markdown = true}
local bib = {default_path = nil, find_in_root = true}
local perspective = {priority = "first", fallback = "current", nvim_wd_heel = false, update = false, root_tell = false}
local links
local function _1_(text)
  return (os.date("%Y-%m-%d_") .. text:gsub(" ", "-"):lower())
end
links = {style = "markdown", context = 0, implicit_extension = nil, transform_explicit = _1_, name_is_source = false, transform_implicit = false, conceal = false}
local new_file_template = {placeholders = {before = {title = "link_title", date = "os_date"}, after = {}}, template = "# {{ title }}", use_template = false}
local to_do = {symbols = {" ", "-", "X"}, update_parents = true, not_started = " ", in_progress = "-", complete = "X"}
local tables = {trim_whitespace = true, format_on_move = true, auto_extend_cols = false, auto_extend_rows = false}
local mappings = {MkdnEnter = {{"n", "v"}, "<CR>"}, MkdnNextHeading = {"n", "]]"}, MkdnPrevHeading = {"n", "[["}, MkdnIncreaseHeading = {"n", "+"}, MkdnDecreaseHeading = {"n", "-"}, MkdnToggleToDo = {{"n", "v"}, "<C-Space>"}, MkdnNewListItemBelowInsert = {"n", "o"}, MkdnNewListItemAboveInsert = {"n", "O"}, MkdnUpdateNumbering = {"n", "<localleader>nn"}, MkdnTableNextRow = {"i", "<S-M-CR>"}, MkdnTablePrevRow = {"i", "<M-CR>"}, MkdnTableNewRowBelow = {"n", "<localleader>ir"}, MkdnTableNewRowAbove = {"n", "<localleader>iR"}, MkdnTableNewColAfter = {"n", "<localleader>ic"}, MkdnTableNewColBefore = {"n", "<localleader>iC"}, MkdnTab = false, MkdnUnfoldSection = false, MkdnFoldSection = false, MkdnTablePrevCell = false, MkdnTableNextCell = false, MkdnExtendList = false, MkdnNewListItem = false, MkdnYankFileAnchorLink = false, MkdnYankAnchorLink = false, MkdnTagSpan = false, MkdnDestroyLink = false, MkdnCreateLinkFromClipboard = false, MkdnCreateLink = false, MkdnFollowLink = false, MkdnPrevLink = false, MkdnNextLink = false, MkdnMoveSource = false, MkdnGoForward = false, MkdnGoBack = false, MkdnSTab = false}
return mkdnflow.setup({create_dirs = true, modules = modules, filetypes = filetypes, bib = bib, perspective = perspective, links = links, new_file_template = new_file_template, to_do = to_do, tables = tables, mappings = mappings, silent = false, wrap = false})
