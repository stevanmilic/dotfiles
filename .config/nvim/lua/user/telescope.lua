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

telescope = require("telescope")
telescope.setup({
	defaults = {
		selection_caret = "❯ ",
		prompt_prefix = "🔍 ",
		layout_config = {
			preview_width = 0.5,
		},
		mappings = {
			i = {
				["<c-j>"] = actions.move_selection_next,
				["<c-b>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<c-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
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
})
telescope.load_extension("fzf")
telescope.load_extension("projects")
