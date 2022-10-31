-- System options
vim.cmd([[
  set showmatch
  set tabstop=4
  set expandtab
  set shiftwidth=4
  set softtabstop=4
  set smarttab
  set clipboard=unnamedplus "share cliboard
  set relativenumber number "hybrid line number
  set ft=tasm "syntax for .asm files
  set ignorecase " case insensitive searching
  set smartcase  " but become case sensitive if you type uppercase characters
  set magic " change the way backslashes are used in search patterns
  set bs=indent,eol,start " Allow backspacing over everything in insert mode
  set fileformat=unix " file mode is unix
  set hlsearch " highlight search (very useful!)
  set incsearch " search incremently (search while typing)
  set timeoutlen=1000 ttimeoutlen=0 " timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays
  set splitbelow "more natural split window for horizontal split
  set splitright "more natural split window for vertical split
  " Gdiff vertical
  set diffopt+=vertical
  set formatexpr=
  set updatetime=100
  set splitkeep=screen
  set nolazyredraw

  syntax enable "syntax highlight enebled
  set termguicolors

  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  "undo to infinity
  set undodir=$HOME/.vim/undofiles
  set undofile
  set noshowmode

  " turn off swap files
  set noswapfile
  set hidden
  set nobackup
  set nowritebackup

  " hide cmdline and statusline
  set cmdheight=0
  set laststatus=0
  set noruler
  set statusline=─
  set fillchars+=stl:─,stlnc:─
  
  let mapleader = ","
]])

-- mappings & autocommands
vim.cmd([[
  " use space to fold/unfold
  nnoremap <silent> <Space> za
  vnoremap <silent> <Space> za

  " Telescope mappings
  nnoremap <c-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>w <cmd>Telescope grep_string<cr>
  nnoremap <leader>a <cmd>Telescope live_grep<CR>
  nnoremap <silent> <Leader>c <cmd>lua require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="class"})<cr>
  nnoremap <silent> <Leader>f <cmd>lua require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="function"})<cr>
  au FileType python nnoremap <silent> <Leader>c <cmd>lua require('telescope.builtin').grep_string({search="class " .. vim.fn.expand("<cword>")})<cr>
  au FileType python nnoremap <silent> <Leader>f <cmd>lua require('telescope.builtin').grep_string({search="def " .. vim.fn.expand("<cword>") .. "("})<cr>
  nnoremap <silent> <leader>x <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ignore_symbols="variable"})<cr>
  nnoremap <silent> <leader>u <cmd>lua require('telescope.builtin').lsp_references({include_declaration=false})<cr>

  " Tab navigation like Firefox.
  nnoremap <silent> <S-tab> :tabprevious<CR>
  " NOTE: Remapping tab also remaps <c-i> this can be fixed by remaping CTRL-n
  " to <tab> to keep the functionality _somewhere_.
  nnoremap <c-n> <tab>
  nnoremap <silent> <tab>   :tabnext<CR>
  nnoremap <silent> <C-t>     :tabnew<CR>
  nnoremap <silent> gb :BufferLinePick<CR>
  nnoremap <silent> <leader>st :windo bd!<CR>
  
  "escape nvim terminal
  tnoremap <Esc> <C-\><C-n>

  "search selected text with //
  vnoremap // y/<C-R>"<CR>
  
  " nvim tree
  nnoremap <leader>n :NvimTreeToggle<CR>
  
  " vertical split with new file
  nnoremap <leader>v :vnew<CR>
  
  " move tabs left and right
  nnoremap <leader>h :tabm -1<CR>
  nnoremap <leader>l :tabm +1<CR>
  
  " enable nested neovim in terminal with nvr
  if has('nvim')
    let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  endif

  " yank duration highlight in ms
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}

  " exit dap on q
  au FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>

  " breakpoints mapping
  au FileType python map <silent> <leader>b obreakpoint()<esc>
  au FileType python map <silent> <leader>B Obreakpoint()<esc>
  au FileType javascript,typescript,typescriptreact map <silent> <leader>b odebugger;<esc>
  au FileType javascript,typescript,typescriptreact  map <silent> <leader>B Odebugger;<esc>
]])

require("nvim-tree").setup({
	actions = {
		open_file = {
			window_picker = { enable = false },
		},
	},
	view = {
		adaptive_size = true,
		signcolumn = "no",
		mappings = {
			list = {
				{ key = "s", action = "" },
				{ key = "S", action = "" },
			},
		},
	},
})

local toggleterm = require("toggleterm")
toggleterm.setup({
	size = function(_)
		return vim.o.lines * 0.45
	end,
	open_mapping = "<leader>m",
	hide_numbers = false,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
	winbar = {
		enabled = true,
	},
})

require("nvim_comment").setup({
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

-- auto-session
local close_all_floating_wins = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end
require("auto-session").setup({
	auto_session_suppress_dirs = { "~/" },
	pre_save_cmds = { close_all_floating_wins },
})
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos"

-- neotest
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			args = function(runner, _)
				if runner == "pytest" then
					return { "-s", "--tb=short", "-p", "no:warnings", "-vv" }
				else
					return {}
				end
			end,
		}),
		require("neotest-jest")({}),
		require("neotest-scala")({ framework = "utest" }),
	},
	discovery = {
		enabled = false,
	},
	icons = {
		running = "",
		failed = "",
		passed = "",
	},
})

-- ultra fast folds
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require("ufo").setup({
	open_fold_hl_timeout = 0,
	provider_selector = function(_, _)
		return "treesitter"
	end,
})

require("gitlinker").setup({
	opts = { print_url = false, highlight_duration = 300 },
	mappings = "<leader>y",
})

-- substitute setup
require("substitute").setup({})

require("nvim-surround").setup({
	highlight = {
		duration = 300,
	},
})

-- smart dd
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

require("tmux").setup({
	navigation = {
		-- enables default keybindings (C-hjkl) for normal mode
		enable_default_keybindings = true,
	},
	copy_sync = {
		enable = false,
	},
})

require("delaytrain").setup({
	delay_ms = 1000,
	grace_period = 2,
	keys = {
		["nv"] = { "h", "j", "k", "l" },
	},
})

-- neoscroll config
vim.keymap.set({ "n", "v" }, "<ScrollWheelUp>", "<C-y>")
vim.keymap.set({ "n", "v" }, "<ScrollWheelDown>", "<C-e>")
require("neoscroll").setup({
	mappings = { "<C-y>", "<C-e>" },
	respect_scrolloff = true,
	cursor_scrolls_alone = false,
})
require("neoscroll.config").set_mappings({
	["<C-b>"] = { "scroll", { "-0.25", "false", "200" } },
	["<C-f>"] = { "scroll", { "0.25", "false", "200" } },
})

require("leap").add_default_mappings()

require("mini.ai").setup()

vim.cmd([[silent! luafile .local.lua]])
