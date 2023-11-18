return {
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"folke/trouble.nvim",
	"aserowy/tmux.nvim",
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
	},
	"terrortylor/nvim-comment",
	"nvim-tree/nvim-tree.lua",
	"akinsho/bufferline.nvim",
	"kazhala/close-buffers.nvim",
	"akinsho/toggleterm.nvim",
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	{ "rmagatti/auto-session", lazy = false },
	"gbprod/substitute.nvim",
	"kylechui/nvim-surround",
	"rcarriga/nvim-notify",
	"folke/which-key.nvim",
	{ "tpope/vim-abolish", event = "VeryLazy" },
	"willothy/flatten.nvim",
	{ "ggandor/leap.nvim", dependencies = { "ggandor/flit.nvim", "tpope/vim-repeat" } },
	"nvim-pack/nvim-spectre",
	"chrishrb/gx.nvim",
	"echasnovski/mini.ai",
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "development",
	},
	{
		"yanskun/gotests.nvim",
		ft = "go",
		config = function()
			require("gotests").setup()
		end,
	},
	{ "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	{
		"rcarriga/neotest",
		dependencies = {
			"rcarriga/neotest-python",
			"nvim-neotest/neotest-plenary",
			"haydenmeade/neotest-jest",
			"nvim-neotest/neotest-go",
			"stevanmilic/neotest-scala",
		},
	},
	"stevearc/conform.nvim",
	"mfussenegger/nvim-lint",

	-- tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = { max_lines = 2, multiline_threshold = 1, trim_scope = "inner" },
			},
		},
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
		},
	},
	"folke/neodev.nvim",
	"stevanmilic/nvim-lspimport",

	-- extendend syntax
	{ "towolf/vim-helm", lazy = false },
	"gf3/peg.vim",
	"vim-scripts/ebnf.vim",

	-- git
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	"lewis6991/gitsigns.nvim",
	"FabijanZulj/blame.nvim",
	"linrongbin16/gitlinker.nvim",
}
