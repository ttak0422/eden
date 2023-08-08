local config = {
  hint = "floating-big-letter",

  selection_chars = "FJDKSLA;CMRUEIWOQP",

  picker_config = {
    statusline_winbar_picker = {
      selection_display = function(char, windowid)
        return "%=" .. char .. "%="
      end,

      use_winbar = "never",
    },

    floating_big_letter = {
      font = "ansi-shadow",
    },
  },

  show_prompt = false,

  prompt_message = "Pick window: ",

  filter_func = nil,

  filter_rules = {
    autoselect_one = true,
    include_current_win = false,
    bo = {
      filetype = dofile(args.exclude_ft_path),
      buftype = dofile(args.exclude_buf_ft_path),
    },

    wo = {},

    file_path_contains = {},

    file_name_contains = {},
  },
}

-- not work??
require("window-picker").setup(config)

function pick()
  local id = require("window-picker").pick_window()
  if id ~= nil then
    local win_cfg = vim.api.nvim_win_get_config(id)
    if win_cfg.focusable then
      vim.api.nvim_set_current_win(id)
    end
  end
end,
