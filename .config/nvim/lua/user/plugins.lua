return {
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"folke/trouble.nvim",
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
	"karb94/neoscroll.nvim",
	"ggandor/leap.nvim",
	"echasnovski/mini.ai",
	"windwp/nvim-autopairs",
	{ "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	{
		"rcarriga/neotest",
		dependencies = {
			"rcarriga/neotest-python",
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
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/playground",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"yioneko/nvim-yati",

	-- lsp
	"neovim/nvim-lspconfig",
	"scalameta/nvim-metals",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"onsails/lspkind-nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-dap-python",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"folke/neodev.nvim",

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
		},
	},

	-- extendend syntax
	"towolf/vim-helm",
	"gf3/peg.vim",
	"vim-scripts/ebnf.vim",

	-- git
	{ "tpope/vim-fugitive", lazy = false },
	-- TODO: revert to original repo once the PR is merged.
	"stevanmilic/gitlinker.nvim",
}
