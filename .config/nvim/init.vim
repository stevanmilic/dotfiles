" Dein ftw ----------------------------------------------{{{
"
if &compatible
	set nocompatible
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.config/nvim/'))

" neo ftw
call dein#add('Shougo/dein.vim')
call dein#add('neomake/neomake') "h neomake -> docs
call dein#add('Shougo/deoplete.nvim') "h deoplate -> docs

" you knoow stuff
call dein#add('ervandew/supertab') "support for deoplete!
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('altercation/vim-colors-solarized')
call dein#add('Chiel92/vim-autoformat')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-repeat')
call dein#add('vim-scripts/ReplaceWithRegister')
call dein#add('tpope/vim-surround')
call dein#add('vim-scripts/restore_view.vim')
call dein#add('rking/ag.vim')
call dein#add('godlygeek/tabular')
call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
call dein#add('scrooloose/nerdtree')
" call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})

" extended auto completion
call dein#add('zchee/deoplete-clang')
call dein#add('zchee/deoplete-jedi')
call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
call dein#add('carlitux/deoplete-ternjs')
call dein#add('ternjs/tern_for_vim')
call dein#add('mhartington/nvim-typescript')
call dein#add('racer-rust/vim-racer')
call dein#add('apalmer1377/factorus')

" extended syntax
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('StanAngeloff/php.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('vim-python/python-syntax')
call dein#add('rust-lang/rust.vim')
call dein#add('magicalbanana/vim-sql-syntax')
call dein#add('othree/html5.vim')
call dein#add('HerringtonDarkholme/yats.vim')

" git
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')
call dein#add('Xuyuanp/nerdtree-git-plugin')

" cool icons
call dein#add('ryanoasis/vim-devicons')

" auotomatic updates
" if dein#check_install()
" 	call dein#install()
" endif

call dein#end()

filetype plugin indent on
" }}}

" System settings -----------------------------------------------------{{{
set showmatch
set autoindent
set smartindent
set tabstop=4
set expandtab
set shiftwidth=2
set softtabstop=2
set smarttab
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
"eneble italic
set t_ZH=[3m
set t_ZR=[23m
" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
"undo to infinity
set undodir=$HOME/.vim/undofiles
set undofile
"}}}

" Fold section --------------------------------------------------------{{{

" open all folds with zR, close all folds with zM

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
set foldmethod=syntax "fold according to syntax
set foldlevelstart=1
set fillchars=fold:\ 
let g:php_folding=2
autocmd FileType vim setlocal fdc=1
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0
autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
" autocmd FileType py setlocal foldmethod=indent
" let g:SimpylFold_docstring_preview = 1

"no auto fold while typing
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" use space to fold/unfold
nnoremap <Space> za
vnoremap <Space> za

"restore view plugin - restores fold and cursor info
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']
" }}}

" AutoCompletion section ----------------------------------------------{{{

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci

"NeoStuff wuhu!
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang/3.8/include'
let g:deoplete#enable_smart_case = 1

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.python = ['around']

let mapleader = ","

let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1

" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = '<Leader>_K'
let g:jedi#auto_close_doc = 1

" let g:deoplete#auto_completion_start_length = 1
" let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources.python = ['omni']

let g:racer_cmd = "/home/stevan/.cargo/bin/cargo"
let g:racer_experimental_completer = 1

" }}}

" Everything else (not much tho) --------------------------------------{{{
"
"solarized colorscheme setup
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
"set t_Co=16
set background=dark
colorscheme solarized

"ctrlp - file open -> easy
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && comm --nocheck-order -3 <(git ls-files -co --exclude-standard) <(git ls-files -i --exclude-from=.gitignore)']

hi! link SignColumn LineNr

"use python in vim editing
:vnoremap <S-Tab> :!python<CR>

"comment lines with (ctrl + /)x2 or with gc (gcc)
vnoremap <c-/> :TComment<cr>

"autoformat setup for php - html data and c,c++
" let g:autoformat_verbosemode=1 " debugging
noremap <F3> :Autoformat<CR>
let g:formatdef_my_custom_php = '"html-beautify"'
let g:formatters_php = ['my_custom_php']
let g:formatdef_my_custom_c = '"astyle --mode=c --style=kr -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatters_c = ['my_custom_c']
let g:formatdef_my_custom_cpp = '"astyle --mode=c --style=kr -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatters_cpp = ['my_custom_cpp']

"set filename for tmux windows
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window zsh")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" let g:neomake_open_list = 1
autocmd! BufWritePost * Neomake
let g:neomake_c_enabled_makers=["gcc"]
let g:neomake_c_gcc_args = ["-Wextra", "-Wall", "-std=c99", "-pedantic", "-Wshadow", "-Wpointer-arith", "-Wcast-qual"]
let g:neomake_cpp_enabled_makers=["gcc"]
let g:neomake_cpp_gcc_args = ["-Wextra", "-Wall", "-pedantic"]

let g:neomake_python_enabled_makers = ["pep8", "pylint"]
let g:neomake_python_pep8_args = ["--max-line-length=119"]

"supertab natural
let g:SuperTabDefaultCompletionType = "<c-n>"

"javascript 
let g:neomake_javascript_enabled_makers = ['jshint']

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

let g:neomake_typescript_enabled_makers = ['tsc']

"save a session
map <F9> :mksession! ~/.nvim_session <cr> " Quick write session with F11
map <F10> :source ~/.nvim_session <cr>     " And load session with F12

" Tab navigation like Firefox.
nnoremap <S-tab> :tabprevious<CR>
nnoremap <tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

"escape nvim terminal
tnoremap <Esc> <C-\><C-n>

"search selected text with //
vnoremap // y/<C-R>"<CR>

au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
au VimEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"

" extended python syntax
let g:python_highlight_all = 1
let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"

" Enable jedi source debug messages
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#source('jedi', 'debug_enabled', 1)

"no line numbers in terminal mode
au TermOpen * setlocal nonumber norelativenumber

"nerdtree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeWinSize=45

"vim repeat plugin
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" }}}
