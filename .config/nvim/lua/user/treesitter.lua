require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	ignore_install = { "phpdoc" },
	incremental_selection = { enable = false },
	indent = {
		enable = false,
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
	yati = { enable = true },
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["at"] = "@class.outer",
				["it"] = "@class.inner",
				["ap"] = "@parameter.outer",
				["ip"] = "@parameter.inner",
				["al"] = "@call.outer",
				["il"] = "@call.inner",
				["as"] = "@statement.outer",
				["ac"] = "@comment.outer",
			},
		},
	},
})

require("nvim-treesitter.configs").setup({
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.fuse = {
	install_info = {
		url = "https://github.com/stevanmilic/tree-sitter-fuse",
		files = { "src/parser.c", "src/scanner.cc" },
	},
}
local python_folds_query = [[
    [
      (function_definition)
      (class_definition)
      (import_from_statement)
      (string)
    ] @fold
]]
require("vim.treesitter.query").set_query("python", "folds", python_folds_query)
