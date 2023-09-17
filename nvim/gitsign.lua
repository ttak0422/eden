require("gitsigns").setup({
  signcolumn = false,
  numhl = true,
  status_formatter = function(status)
    local added, changed, removed = status.added, status.changed, status.removed
    local status_txt = {}
    if added and added > 0 then
      table.insert(status_txt, " " .. added)
    end
    if changed and changed > 0 then
      table.insert(status_txt, " " .. changed)
    end
    if removed and removed > 0 then
      table.insert(status_txt, " " .. removed)
    end
    return table.concat(status_txt, " ")
  end,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 1000,
  max_file_length = 40000,
  preview_config = {
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
})
