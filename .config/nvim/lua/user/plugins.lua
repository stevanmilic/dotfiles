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
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use("christoomey/vim-tmux-navigator")
	use("lifepillar/vim-solarized8")
	use("b3nj5m1n/kommentary")
	use("tpope/vim-repeat")
	use("inkarkat/vim-ReplaceWithRegister")
	use("tpope/vim-surround")
	use("wellle/targets.vim")
	use("zhimsel/vim-stay")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	use("tpope/vim-abolish")
	use("junegunn/goyo.vim")
	use("janko-m/vim-test")
	use("machakann/vim-highlightedyank")
	use("akinsho/nvim-bufferline.lua")
	use("arithran/vim-delete-hidden-buffers")
	use("moll/vim-bbye")
	use("NTBBloodbath/galaxyline.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup({ autoresize = false })
		end,
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	use("nathom/filetype.nvim")
	use("lewis6991/impatient.nvim")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	})

	-- lsp
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("onsails/lspkind-nvim")
	use("tami5/lspsaga.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	-- use "ray-x/lsp_signature.nvim"

	-- extendend syntax
	use("towolf/vim-helm")
	use("pearofducks/ansible-vim")
	use("gf3/peg.vim")
	use("vim-scripts/ebnf.vim")

	-- git
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
