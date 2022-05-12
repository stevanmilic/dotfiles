-- System options
vim.cmd([[
  set showmatch
  set autoindent
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
  
  " folds
  set foldlevelstart=1
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  
  let mapleader = ","

  " 0.7 nvim filetype detection
  let g:do_filetype_lua = 1
  let g:did_load_filetypes = 1
]])

-- mappings, autocommands and stuff
vim.cmd([[
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  
  " use space to fold/unfold
  nnoremap <Space> za
  vnoremap <Space> za

  " don't give |ins-completion-menu| messages.
  autocmd BufEnter *.tpl setlocal filetype=htmldjango
  
  nnoremap <c-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>w <cmd>Telescope grep_string<cr>

  nnoremap <leader>a :Telescope live_grep<CR>
  nnoremap <silent> <Leader>c :Telescope grep_string search=class\ <C-R><C-W>(<CR>
  nnoremap <silent> <Leader>f :Telescope grep_string search=def\ <C-R><C-W>(<CR>
  nnoremap <silent> <leader>x :lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
  
  " Tab navigation like Firefox.
  nnoremap <silent> <S-tab> :tabprevious<CR>
  nnoremap <silent> <tab>   :tabnext<CR>
  nnoremap <silent> <C-t>     :tabnew<CR>
  nnoremap <silent> gb :BufferLinePick<CR>
  nnoremap <silent> <leader>st :windo bd!<CR>
  
  "escape nvim terminal
  tnoremap <Esc> <C-\><C-n>

  "search selected text with //
  vnoremap // y/<C-R>"<CR>
  
  let g:python3_host_prog = "/Users/Stevan.Milic/Applications/neovim-venv/bin/python"
  
  " breakpoints mapping
  au FileType python map <silent> <leader>b obreakpoint()<esc>
  au FileType python map <silent> <leader>B Obreakpoint()<esc>
  au FileType javascript,typescript,typescriptreact map <silent> <leader>b odebugger;<esc>
  au FileType javascript,typescript,typescriptreact  map <silent> <leader>B Odebugger;<esc>
  
  "no line numbers in terminal mode
  au TermOpen * setlocal nonumber norelativenumber
  
  " nvim tree
  nnoremap <leader>n :NvimTreeToggle<CR>
  
  " vertical split with new file
  nnoremap <leader>v :vnew<CR>
  
  " move tabs left and right
  nnoremap <leader>h :tabm -1<CR>
  nnoremap <leader>l :tabm +1<CR>
  
  " enable nested neovim in terminal with nvr
  if has('nvim')
    let $VISUAL = 'nvr -cc split --remote-wait'
  endif
  
  "vim repeat plugin
  silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
  
  let test#strategy = "neovim"
  let test#scala#runner = 'blooptest'
  
  let test#python#runner = 'pytest'
  let test#python#pytest#options = '-s --tb=short'
  
  nmap <Leader>tn :TestNearest<CR>
  nmap <Leader>tf :Ultest<CR>
  nmap <Leader>ts :TestSuite<CR>
  nmap <Leader>tl :TestLast<CR>
  nmap <Leader>tv :TestVisit<CR>

  let g:ultest_output_on_run = "0"
  let g:ultest_output_on_line = "0"
  let g:ultest_running_sign = ''
  let g:ultest_pass_sign = ''
  let g:ultest_fail_sign = ''
  
  " yank duration highlight in ms
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}

  let g:pyrightTypeCheckingMode = "off"
  silent! so .local.vim
]])

local colors = require("onenord.colors").load()

require("onenord").setup({
	borders = true,
	fade_nc = false,
	styles = {
		comments = "NONE",
		strings = "NONE",
		keywords = "NONE",
		functions = "NONE",
		variables = "bold",
		diagnostics = "underline",
	},
	disable = {
		background = false,
		cursorline = false,
		eob_lines = true,
	},
	custom_highlights = {
		-- TelescopePromptBorder = { bg = colors.bg, fg = colors.fg },
		-- TelescopeResultsBorder = { bg = colors.bg, fg = colors.fg },
		-- TelescopePreviewBorder = { bg = colors.bg, fg = colors.fg },
		TSParameter = { fg = colors.fg },
	},
})

require("nvim-tree").setup({
	actions = {
		open_file = {
			window_picker = { enable = false },
		},
	},
})

require("toggleterm").setup({
	size = 10,
	open_mapping = "<leader>m",
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

require("pretty-fold").setup({
	keep_indentation = true,
	fill_char = " ",
	sections = {
		left = {
			"content",
		},
		right = { " ", "number_of_folded_lines" },
	},
})

require("nvim_comment").setup({
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

require("fidget").setup({})

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
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
