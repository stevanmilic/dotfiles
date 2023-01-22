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
	yati = {
		enable = true,
	},
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
				["ac"] = "@call.outer",
				["ic"] = "@call.inner",
				["as"] = "@statement.outer",
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

local query_config = require("vim.treesitter.query")
local python_folds_query = [[
    [
      (function_definition)
      (class_definition)
      (import_from_statement)
      (string)
    ] @fold
]]
query_config.set_query("python", "folds", python_folds_query)

local python_graphql_injection_query = [[
    (call
     function: ((identifier) @_name
       (#eq? @_name "gql"))
     arguments: (argument_list (string) @graphql
       (#offset! @graphql 0 3 0 -3)))
]]
query_config.set_query("python", "injections", python_graphql_injection_query)

local scala_injections_query = [[
    (call_expression
     function: ((identifier) @_name
       (#eq? @_name "fuse"))
     arguments: (arguments (string) @fuse
       (#offset! @fuse 0 1 0 -1)))
]]
query_config.set_query("scala", "injections", scala_injections_query)
