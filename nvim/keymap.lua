vim.cmd([[
  tnoremap <ESC> <c-\><c-n><Plug>(esc)
  nnoremap <Plug>(esc)<ESC> i<ESC>
]])

local function desc(d)
  return { noremap = true, silent = true, desc = d }
end

local function toggle_tool()
  local is_open = false
  local pre_id = nil
  return function(id, mod, opt)
    return function()
      local t = require("toolwindow")
      if pre_id ~= id then
        t.open_window(mod, opt)
        is_open = true
      else
        if is_open then
          t.close()
          is_open = false
        else
          t.open_window(mod, opt)
          is_open = true
        end
      end
      pre_id = id
    end
  end
end
local toggle = toggle_tool()
local map = vim.keymap.set

local normal_keymaps = {
  { "<leader>tq", toggle(1, "quickfix", nil), desc("open quickfix") },
  {
    "<leader>td",
    toggle(2, "trouble", { mode = "document_diagnostics" }),
    desc("open diagnostics (document)"),
  },
  {
    "<leader>tD",
    toggle(3, "trouble", { mode = "workspace_diagnostics" }),
    desc("open diagnostics (workspace)"),
  },
}

for _, keymap in ipairs(normal_keymaps) do
  map("n", keymap[1], keymap[2], keymap[3])
end
