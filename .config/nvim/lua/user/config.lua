-- System settings
vim.cmd([[
  set showmatch
  set autoindent
  set tabstop=4
  set expandtab
  set shiftwidth=4
  set softtabstop=4
  set smarttab
  " set nowrap
  set clipboard=unnamedplus "share cliboard
  set relativenumber number "hybrid line number
  set ft=tasm "syntax for .asm files
  " set shellcmdflag=-ic
  set ignorecase " case insensitive searching
  set smartcase  " but become case sensitive if you type uppercase characters
  set magic " change the way backslashes are used in search patterns
  set bs=indent,eol,start " Allow backspacing over everything in insert mode
  set fileformat=unix " file mode is unix
  set hlsearch " highlight search (very useful!)
  set incsearch " search incremently (search while typing)
  " map <esc> :noh<cr>  quit incremental search
  set timeoutlen=1000 ttimeoutlen=0 "timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays
  "set laststatus=0 "disable statusline
  set splitbelow "more natural split window for horizontal split
  set splitright "more natural split window for vertical split
  syntax enable "syntax highlight enebled
  set directory=$HOME/.vim/swapfiles "special directory for swap files
  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  "undo to infinity
  set undodir=$HOME/.vim/undofiles
  set undofile
  set noshowmode
  " turn off swap files
  set noswapfile
  
  let mapleader = ","
  " 0.7 nvim filetype detection
  let g:do_filetype_lua = 1
  let g:did_load_filetypes = 1
]])

-- folds
vim.cmd([[
  function! MyFoldText() "{{{
  	let line = getline(v:foldstart)
  
  	let nucolwidth = &fdc + &number * &numberwidth
  	let windowwidth = winwidth(0) - nucolwidth - 3
  	let foldedlinecount = v:foldend - v:foldstart
  
  	" expand tabs into spaces
  	let onetab = strpart('          ', 0, &tabstop)
  	let line = substitute(line, '\t', onetab, 'g')
  
  	let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  	let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  	return line . repeat(" ",fillcharcount)
  endfunction "}}}
  
  set foldtext=MyFoldText()
  set foldlevelstart=1
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  
  set fillchars=fold:\ 
  autocmd FileType vim setlocal fdc=1
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0
  autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  
  " use space to fold/unfold
  nnoremap <Space> za
  vnoremap <Space> za
  
  "restore view plugin - restores fold and cursor info
  set viewoptions=cursor,folds
]])

-- mappings and stuff
vim.cmd([[
  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup
  
  " don't give |ins-completion-menu| messages.
  set shortmess+=c
  
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
  " autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci
  autocmd BufEnter *.tpl setlocal filetype=htmldjango
  
  nnoremap <c-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>w <cmd>Telescope grep_string<cr>

  nnoremap <leader>a :Telescope live_grep<CR>
  nnoremap <silent> <Leader>c :Telescope grep_string search=class\ <C-R><C-W>(<CR>
  nnoremap <silent> <Leader>f :Telescope grep_string search=def\ <C-R><C-W>(<CR>
  " nnoremap <silent> <Leader>x :Telescope grep_string search=
  "
  nnoremap <silent> <leader>x :lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
  nnoremap <silent> <leader>u :lua require('telescope.builtin').lsp_references()<cr>
  
  "solarized colorscheme setup
  set termguicolors
  colorscheme solarized8
  let g:solarized_statusline = "flat"
  let g:solarized_extra_hi_groups= "1"
  let g:solarized_visibility = "low"
  let g:solarized_old_cursor_style= "1"
  set background=dark
  
  hi! link SignColumn LineNr
  
  "use python in vim editing
  :vnoremap <S-Tab> :!python<CR>
  
  "save a session
  map <F9> :mksession! ~/.nvim_session <cr> " Quick write session with F9
  map <F10> :source ~/.nvim_session <cr>     " And load session with F10
  
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
  
  let g:python_host_prog = "/home/stevan/Applications/neovim-venvs/neovim2/bin/python"
  let g:python3_host_prog = "/home/stevan/Applications/neovim-venvs/neovim3/bin/python"
  
  " breakpoints mapping
  au FileType python map <silent> <leader>b obreakpoint()<esc>
  au FileType python map <silent> <leader>B Obreakpoint()<esc>
  au FileType javascript,typescript,typescriptreact map <silent> <leader>b odebugger;<esc>
  au FileType javascript,typescript,typescriptreact  map <silent> <leader>B Odebugger;<esc>
  
  "no line numbers in terminal mode
  au TermOpen * setlocal nonumber norelativenumber
  
  " nvim tree
  nnoremap <leader>n :NvimTreeToggle<CR>
  
  " Gdiff vertical
  set diffopt+=vertical
  
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
  nmap <Leader>tf :TestFile<CR>
  nmap <Leader>ts :TestSuite<CR>
  nmap <Leader>tl :TestLast<CR>
  nmap <Leader>tv :TestVisit<CR>
  
  " open terminal in new tab and vsplit
  nnoremap <silent> <leader>m :tabnew  +term<CR>
  " nnoremap <silent> <leader>m :vnew  +term<CR>
  
  " yank duration highlight in ms
  let g:highlightedyank_highlight_duration = 500
  
  highlight link LspSagaRenameBorder Normal
  highlight link LspSagaHoverBorder Normal
  highlight link LspSagaDiagnosticBorder Normal
  highlight link LspSagaDiagnosticTruncateLine Normal
  highlight link LspSagaCodeActionBorder Normal
  highlight link LspSagaSignatureHelpBorder Normal
  highlight link LspSagaDefPreviewBorder Normal
  highlight link LspLinesDiagBorder Normal
  highlight link LspSagaCodeActionTruncateLine Normal
  highlight link DiagnosticTruncateLine Normal
  highlight link LspSagaDiagnosticTruncateLine Normal
  highlight link LspSagaShTruncateLine Normal
  highlight link LspSagaCodeActionTruncateLine Normal
  highlight link markdownError NONE


  let g:pyrightTypeCheckingMode = "off"
  silent! so .local.vim
]])

require("nvim-tree").setup({
	actions = {
		open_file = {
			window_picker = { enable = false },
		},
	},
})
