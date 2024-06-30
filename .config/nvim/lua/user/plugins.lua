return {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"folke/trouble.nvim",
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
	},
	{ "akinsho/toggleterm.nvim", version = "*" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "rmagatti/auto-session", lazy = false },
	"gbprod/substitute.nvim",
	"kylechui/nvim-surround",
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
			render = "wrapped-compact",
			stages = "no_animation",
			top_down = false,
		},
	},
	"folke/which-key.nvim",
	"willothy/flatten.nvim",
	"echasnovski/mini.ai",
	"echasnovski/mini.clue",
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter" },
		branch = "development",
	},
	{
		"rcarriga/neotest",
		dependencies = {
			"rcarriga/neotest-python",
			"nvim-neotest/neotest-plenary",
			"haydenmeade/neotest-jest",
			"nvim-neotest/neotest-go",
			"stevanmilic/neotest-scala",
			-- { dir = "/Users/Stevan.Milic/Applications/neotest-scala" },
		},
	},
	"stevearc/conform.nvim",
	{ "smoka7/hop.nvim", version = "*" },

	-- tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		name = "lsp",
		event = "BufReadPre",
		dependencies = {
			-- "kosayoda/nvim-lightbulb"
			"gh-liu/nvim-lightbulb",
		},
	},
	{ "echasnovski/mini.completion", version = "*" },
	{ "dgagn/diagflow.nvim", event = "LspAttach" },
	"j-hui/fidget.nvim",
	"scalameta/nvim-metals",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"jay-babu/mason-nvim-dap.nvim",
			"leoluz/nvim-dap-go",
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{ "LiadOz/nvim-dap-repl-highlights", config = true },
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	"folke/neodev.nvim",

	-- git
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	"lewis6991/gitsigns.nvim",
	"linrongbin16/gitlinker.nvim",
}
