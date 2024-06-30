local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")
local telescope = require("telescope")
telescope.setup({
	defaults = {
		selection_caret = "❯ ",
		prompt_prefix = "🔍 ",
		path_display = { "truncate" },
		winblend = 0,
        sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				preview_width = 0.55,
				results_width = 0.8,
                prompt_position = "top",
			},
			vertical = {
				mirror = false,
			},
			width = 0.80,
			height = 0.85,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<c-j>"] = actions.move_selection_next,
				["<c-b>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<c-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
				["<c-q>"] = trouble.open,
				["<c-f>"] = actions.to_fuzzy_refine,
			},
		},
	},
})
