require("noice").setup({
	cmdline = {
		view = "cmdline",
		format = {
			search_down = { icon = "🔍" },
			search_up = { icon = "🔍" },
		},
	},
	popupmenu = { enabled = false },
	lsp = {
		override = {
			-- override the default lsp markdown formatter with Noice
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			-- override the lsp markdown formatter with Noice
			["vim.lsp.util.stylize_markdown"] = true,
			-- override cmp documentation with Noice (needs the other options to work)
			["cmp.entry.get_documentation"] = true,
		},
	},
	routes = {
		{
			filter = { event = "msg_show", kind = "search_count" },
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "[+]",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "<",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "line",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "notify",
				find = "Session restored",
			},
			view = "notify",
			opts = { skip = true },
		},
	},
})
