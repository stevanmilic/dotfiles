return {
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "folke/trouble.nvim", config = true },
	"aserowy/tmux.nvim",
	"rmehri01/onenord.nvim",
	"terrortylor/nvim-comment",
	"kyazdani42/nvim-tree.lua",
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
	"johmsalas/text-case.nvim",
	"ja-ford/delaytrain.nvim",
	"stevanmilic/neoscroll.nvim",
	"willothy/flatten.nvim",
	"ggandor/leap.nvim",
	"nvim-pack/nvim-spectre",
	"chrishrb/gx.nvim",
	"echasnovski/mini.ai",
	"windwp/nvim-autopairs",
	{ "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	{
		"rcarriga/neotest",
		dependencies = {
			"rcarriga/neotest-python",
			"nvim-neotest/neotest-plenary",
			"haydenmeade/neotest-jest",
			"stevanmilic/neotest-scala",
		},
	},

	-- tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"yioneko/nvim-yati",
		},
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		name = "lsp",
		event = "BufReadPre",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "jose-elias-alvarez/null-ls.nvim" },
	},
	"scalameta/nvim-metals",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap-python" },
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
	},
	"folke/neodev.nvim",

	-- extendend syntax
	{ "towolf/vim-helm", lazy = false },
	"gf3/peg.vim",
	"vim-scripts/ebnf.vim",

	-- git
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	-- TODO: revert to original repo once the PR is merged.
	"stevanmilic/gitlinker.nvim",
}
