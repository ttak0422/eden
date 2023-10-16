local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 51
  local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  local validFmt = "[ %4d/%-4d ] %s │%5d:%-3d│%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == "" then
          fname = "[No Name]"
        else
          fname = fname:gsub("^" .. vim.env.HOME, "~")
        end
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      str = validFmt:format(i, info.end_idx, fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

require("bqf").setup({
  func_map = {
    open = "<CR>",
    openc = "o",
    drop = "O",
    split = "<C-x>",
    vsplit = "<C-v>",
    -- open the item in a new tab
    tab = "t",
    -- open the item in a new tab, but stay in quickfix window
    tabb = "T",
    -- open the item in a new tab, and close quickfix window
    tabc = "<C-t>",
    tabdrop = "",
    ptogglemode = "zp",
    ptoggleitem = "p",
    ptoggleauto = "P",
    pscrollup = "<C-b>",
    pscrolldown = "<C-f>",
    pscrollorig = "zo",
    prevfile = "",
    nextfile = "",
    prevhist = "",
    nexthist = "",
    lastleave = [['"]],
    stoggleup = "<S-Tab>",
    stoggledown = "<Tab>",
    stogglevm = "<Tab>",
    stogglebuf = [['<Tab>]],
    sclear = "z<Tab>",
    filter = "zn",
    filterr = "zN",
    fzffilter = "zf",
  },
})
