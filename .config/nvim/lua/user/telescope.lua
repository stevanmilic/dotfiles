local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local fzf_opts = {
	fuzzy = true, -- false will only do exact matching
	override_generic_sorter = true, -- override the generic sorter
	override_file_sorter = true, -- override the file sorter
	case_mode = "smart_case", -- or "ignore_case" or "respect_case"
	-- the default case_mode is "smart_case"
}
telescope.setup({
	defaults = {
		selection_caret = "❯ ",
		prompt_prefix = "🔍 ",
		winblend = 0,
		layout_config = {
			horizontal = {
				preview_width = 0.55,
				results_width = 0.8,
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
				["<c-q>"] = trouble.smart_open_with_trouble,
				["<c-f>"] = actions.to_fuzzy_refine,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" },
		},
		lsp_dynamic_workspace_symbols = {
			sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
		},
	},
	extensions = {
		fzf = fzf_opts,
	},
})
telescope.load_extension("fzf")
