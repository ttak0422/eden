local previewer = require("ddc_previewer_floating")
  previewer.setup({
  ui = "pum",
  max_height = 30,
  max_width = 80,
	border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
})

previewer.enable();
