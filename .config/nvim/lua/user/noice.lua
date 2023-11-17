require("noice").setup({
	lsp = {
		progress = {
			enabled = false,
		},
	},
	cmdline = {
		view = "cmdline",
		format = {
			search_down = { icon = "🔍" },
			search_up = { icon = "🔍" },
		},
	},
	popupmenu = { enabled = false },
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
		{
			filter = {
				event = "msg_show",
				find = "No fold found",
			},
			opts = { skip = true },
		},
	},
})
