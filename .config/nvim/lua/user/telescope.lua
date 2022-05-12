local actions = require("telescope.actions")
local telescope_actions = require("telescope.actions.set")

local fix_folds = {
	hidden = true,
	attach_mappings = function(_)
		telescope_actions.select:enhance({
			post = function()
				vim.cmd(":normal! zx")
			end,
		})
		return true
	end,
}

local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
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
			},
		},
	},
	pickers = {
		find_files = fix_folds,
		grep_string = fix_folds,
		live_grep = fix_folds,
		lsp_references = fix_folds,
		lsp_dynamic_workspace_symbols = fix_folds,
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
telescope.load_extension("fzf")
