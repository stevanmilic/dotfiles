require("nord").setup({
	borders = true,
	on_highlights = function(highlights, colors)
		highlights["@parameter"] = { fg = colors.snow_storm.origin }
		highlights["Folded"] = { fg = colors.snow_storm.brightest }
		highlights["StatusLineNC"] = { bg = "NONE" }
		highlights["StatusLine"] = { bg = "NONE" }
	end,
})
vim.cmd.colorscheme("nord")
