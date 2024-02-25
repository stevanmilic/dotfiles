return {
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"folke/trouble.nvim",
	"aserowy/tmux.nvim",
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
	},
	"terrortylor/nvim-comment",
	"nvim-tree/nvim-tree.lua",
	{
		"stevanmilic/barbecue.nvim",
		name = "barbecue",
		branch = "feature/navic-depth-limit",
		dependencies = { "SmiteshP/nvim-navic" },
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
	"johmsalas/text-case.nvim",
	"willothy/flatten.nvim",
	{
		"ggandor/leap.nvim",
		dependencies = {
			"ggandor/flit.nvim",
			"tpope/vim-repeat",
		},
	},
	"nvim-pack/nvim-spectre",
	{ "chrishrb/gx.nvim", keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } } },
	"echasnovski/mini.ai",
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "development",
	},
	{ "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	{
		"rcarriga/neotest",
		dependencies = {
			"rcarriga/neotest-python",
			"nvim-neotest/neotest-plenary",
			"haydenmeade/neotest-jest",
			"nvim-neotest/neotest-go",
			-- "stevanmilic/neotest-scala",
			{ dir = "/Users/Stevan.Milic/Applications/neotest-scala" },
		},
	},
	"stevearc/conform.nvim",
	"mfussenegger/nvim-lint",
	{ "zbirenbaum/copilot.lua", event = "InsertEnter" },
	"luukvbaal/statuscol.nvim",

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
			"kosayoda/nvim-lightbulb",
		},
	},
	{ "dgagn/diagflow.nvim", event = "LspAttach" },
	"j-hui/fidget.nvim",
	"scalameta/nvim-metals",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
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
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"rcarriga/cmp-dap",
			{ "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" },
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"lukas-reineke/cmp-under-comparator",
			"zbirenbaum/copilot-cmp",
		},
	},
	"folke/neodev.nvim",
	"stevanmilic/nvim-lspimport",

	-- extendend syntax
	{ "towolf/vim-helm", lazy = false },

	-- git
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	"lewis6991/gitsigns.nvim",
	"linrongbin16/gitlinker.nvim",
}
