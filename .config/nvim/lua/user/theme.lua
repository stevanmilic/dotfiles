local colors = require("onenord.colors").load()
require("onenord").setup({
	borders = true,
	fade_nc = false,
	styles = {
		comments = "NONE",
		strings = "NONE",
		keywords = "NONE",
		functions = "NONE",
		variables = "bold",
		diagnostics = "underline",
	},
	disable = {
		background = false,
		cursorline = false,
		eob_lines = true,
	},
	custom_highlights = {
		Folded = { fg = colors.dark_blue, bg = colors.none, style = "none" },
		StatusLineNC = { bg = "NONE" },
		StatusLine = { bg = "NONE" },
		["@parameter"] = { fg = colors.fg },
		LeapMatch = { link = "Special" },
		LeapLabelPrimary = { link = "IncSearch" },
		TelescopeBorder = {
			fg = colors.float,
			bg = colors.float,
		},
		TelescopePromptBorder = {
			fg = colors.float,
			bg = colors.float,
		},
		TelescopeResultsBorder = { fg = colors.active, bg = colors.active },
		TelescopePreviewBorder = { fg = colors.active, bg = colors.active },
		TelescopePromptNormal = {
			fg = colors.white,
			bg = colors.float,
		},
		TelescopePromptPrefix = {
			fg = colors.red,
			bg = colors.float,
		},
		TelescopeNormal = { bg = colors.active },
		TelescopePreviewTitle = {
			fg = colors.bg,
			bg = colors.green,
		},
		TelescopePromptTitle = {
			fg = colors.bg,
			bg = colors.red,
		},
		TelescopeResultsTitle = {
			fg = colors.bg,
			bg = colors.purple,
		},
		TelescopeSelection = { bg = colors.float, fg = colors.white },
		TelescopeResultsDiffAdd = {
			fg = colors.green,
		},
		TelescopeResultsDiffChange = {
			fg = colors.yellow,
		},
		TelescopeResultsDiffDelete = {
			fg = colors.red,
		},
	},
})
