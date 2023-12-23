require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	ignore_install = { "phpdoc" },
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			node_decremental = "V",
		},
	},
	indent = {
		enable = true,
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
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
query_config.set("python", "folds", python_folds_query)

local python_graphql_injection_query = [[
    (call
     function: ((identifier) @_name
       (#eq? @_name "gql"))
     arguments: (argument_list (string (string_content) @injection.content
       (#set! injection.language "graphql"))))
]]
query_config.set("python", "injections", python_graphql_injection_query)

local scala_injections_query = [[
    (call_expression
     function: ((identifier) @_name
       (#eq? @_name "fuse"))
     arguments: (arguments (string) @injection.content
       (#offset! @injection.content 0 1 0 -1)
       (#set! injection.language "fuse")))
]]
query_config.set("scala", "injections", scala_injections_query)
