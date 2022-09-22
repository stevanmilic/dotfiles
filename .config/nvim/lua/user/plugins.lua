-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("folke/trouble.nvim")
	use("aserowy/tmux.nvim")
	use("rmehri01/onenord.nvim")
	use("terrortylor/nvim-comment")
	use("kyazdani42/nvim-tree.lua")
	use({ "akinsho/bufferline.nvim", tag = "*" })
	use("kazhala/close-buffers.nvim")
	use("lewis6991/impatient.nvim")
	use("akinsho/toggleterm.nvim")
	use("stevearc/dressing.nvim")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use("rmagatti/auto-session")
	use({
		"rcarriga/neotest",
		requires = {
			"rcarriga/neotest-python",
			"haydenmeade/neotest-jest",
			"stevanmilic/neotest-scala",
		},
	})
	use("gbprod/substitute.nvim")
	use("kylechui/nvim-surround")
	use("luukvbaal/stabilize.nvim")
	use("rcarriga/nvim-notify")
	use("folke/which-key.nvim")
	use("johmsalas/text-case.nvim")

	-- vimscript plugins
	use("janko-m/vim-test")
	use("wellle/targets.vim")

	-- tree-sitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })

	-- lsp
	use("neovim/nvim-lspconfig")
	use("scalameta/nvim-metals")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("onsails/lspkind-nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("j-hui/fidget.nvim")
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-dap-python")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("folke/lua-dev.nvim")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- extendend syntax
	use("towolf/vim-helm")
	use("gf3/peg.vim")
	use("vim-scripts/ebnf.vim")

	-- git
	use("tpope/vim-fugitive")
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	-- TODO: revert to original repo once the PR is merged.
	use("stevanmilic/gitlinker.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
