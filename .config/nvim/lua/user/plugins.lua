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
    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                navigation = {
                    -- enables default keybindings (C-hjkl) for normal mode
                    enable_default_keybindings = true,
                },
            })
        end,
    })
    use("rmehri01/onenord.nvim")
    use("terrortylor/nvim-comment")
    use("kyazdani42/nvim-tree.lua")
    use({ "akinsho/bufferline.nvim", tag = "*" })
    use("kazhala/close-buffers.nvim")
    use({
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup({ autoresize = false })
        end,
    })
    use("lewis6991/impatient.nvim")
    use({ "akinsho/toggleterm.nvim" })
    use({ "stevearc/dressing.nvim" })
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
    use({ "rmagatti/auto-session" })
    use {
        "rcarriga/neotest",
        requires = {
            "rcarriga/neotest-python",
            "rcarriga/neotest-vim-test",
        },
    }
    use { "johmsalas/text-case.nvim", config = function() require('textcase').setup {} end }
    use({ "gbprod/substitute.nvim" })

    -- vimscript plugins
    use("janko-m/vim-test")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("wellle/targets.vim")
    use({
        "antoinemadec/FixCursorHold.nvim",
        event = "BufRead",
        config = function()
            vim.g.cursorhold_updatetime = 100
        end,
    })

    -- tree-sitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("nvim-treesitter/playground")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })

    -- lsp
    use("neovim/nvim-lspconfig")
    use("scalameta/nvim-metals")
    use("williamboman/nvim-lsp-installer")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("onsails/lspkind-nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use("j-hui/fidget.nvim")
    use("mfussenegger/nvim-dap")
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    -- extendend syntax
    use("towolf/vim-helm")
    use("gf3/peg.vim")
    use("vim-scripts/ebnf.vim")

    -- git
    use("tpope/vim-fugitive")
    use("ruifm/gitlinker.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
