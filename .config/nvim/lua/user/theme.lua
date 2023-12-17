local c = require("nord.colors").palette
c.frost.ice = "#7BADC3" -- a slightly darker variation of original color
require("nord").setup({
	borders = true,
	on_highlights = function(highlights, colors)
		highlights["@parameter"] = { fg = colors.snow_storm.origin }
		highlights["Folded"] = { fg = colors.snow_storm.brightest }
		highlights["StatusLineNC"] = { bg = "NONE" }
		highlights["StatusLine"] = { bg = "NONE" }
		highlights["LspInlayHint"] = { fg = colors.polar_night.light, bg = colors.polar_night.bright, italic = true }
	end,
})
vim.cmd.colorscheme("nord")
