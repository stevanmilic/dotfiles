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
call dein#add('junegunn/fzf', {'build': './install --all'})
call dein#add('junegunn/fzf.vim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('altercation/vim-colors-solarized')
" call dein#add('iCyMind/NeoSolarized')
call dein#add('Chiel92/vim-autoformat')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-repeat')
call dein#add('vim-scripts/ReplaceWithRegister')
call dein#add('tpope/vim-surround')
call dein#add('vim-scripts/restore_view.vim')
call dein#add('mileszs/ack.vim')
call dein#add('godlygeek/tabular')
call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
call dein#add('scrooloose/nerdtree')
call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})
call dein#add('tpope/vim-abolish')
" call dein#add('sbdchd/neoformat')
" call dein#add('Shougo/echodoc.vim')
" call dein#add('junegunn/goyo.vim')
call dein#add('janko-m/vim-test')
" call dein#add('skywind3000/asyncrun.vim')

" extended auto completion
call dein#add('zchee/deoplete-clang', {'on_ft': 'cpp'})
call dein#add('zchee/deoplete-jedi')
call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'js'})
call dein#add('ternjs/tern_for_vim', {'on_ft': 'js'})
call dein#add('mhartington/nvim-typescript')
" call dein#add('racer-rust/vim-racer')
call dein#add('apalmer1377/factorus', {'on_ft': 'cpp'})
call dein#add('zchee/deoplete-go', {'build': 'make'})
call dein#add('fatih/vim-go')

" extended syntax
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('StanAngeloff/php.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#add('jparise/vim-graphql')
call dein#add('vim-python/python-syntax')
call dein#add('rust-lang/rust.vim')
call dein#add('magicalbanana/vim-sql-syntax')
call dein#add('othree/html5.vim')
call dein#add('HerringtonDarkholme/yats.vim')
call dein#add('Vimjas/vim-python-pep8-indent')
call dein#add('towolf/vim-helm')
call dein#add('pearofducks/ansible-vim')

" git
" call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('shumphrey/fugitive-gitlab.vim')
call dein#add('tpope/vim-rhubarb')

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
" set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
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
" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
"undo to infinity
set undodir=$HOME/.vim/undofiles
set undofile
set noshowmode
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
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType py setlocal foldmethod=indent

" let g:SimpylFold_docstring_preview = 1
" SimpylFold if doesn't work... 
" set foldmethid=expr
" set foldexpr=SimpylFold#FoldExpr(v:lnum)

"no auto fold while typing
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" use space to fold/unfold
nnoremap <Space> za
vnoremap <Space> za

"restore view plugin - restores fold and cursor info
set viewoptions=cursor,folds,slash,unix

nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

" let g:skipview_files = ['*\.vim']
" }}}

" AutoCompletion section ----------------------------------------------{{{

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci
autocmd BufEnter *.tpl setlocal filetype=htmldjango

"NeoStuff wuhu!
let g:deoplete#enable_at_startup = 1
" let g:echodoc_enable_at_startup = 1

set splitbelow
set completeopt+=noselect
set completeopt-=preview
autocmd CompleteDone * pclose

let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang/3.8/include'
let g:deoplete#enable_smart_case = 1

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()

inoremap <silent><expr> <S-TAB>
  \ pumvisible() ? "\<C-p>" : "\<S-TAB>"

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['around', 'buffer', 'member']
call deoplete#custom#option('auto_complete', v:false)

call deoplete#custom#source('buffer', 'mark', 'ℬ')
call deoplete#custom#source('ternjs', 'mark', '')
call deoplete#custom#source('omni', 'mark', 'omni')
call deoplete#custom#source('file', 'mark', 'file')
call deoplete#custom#source('jedi', 'mark', '')
call deoplete#custom#source('typescript', 'mark', '')
call deoplete#custom#source('neosnippet', 'mark', '')

let mapleader = ","

let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1

" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = '<Leader>_K'
let g:jedi#auto_close_doc = 1

let g:racer_cmd = "/home/stevan/.cargo/bin/cargo"
let g:racer_experimental_completer = 1

" }}}

" Fzf section ----------------------------------------------{{{

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufWinLeave <buffer> set laststatus=2 showmode ruler
augroup END

let $FZF_DEFAULT_COMMAND = 'fd --hidden --type f'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Identifier'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Normal'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('down:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump=1

nnoremap <c-p> :Files<cr>

nnoremap <Leader>a :Rg<Space>
nnoremap <silent> <Leader>c :Rg class <C-R><C-W>(<CR>
nnoremap <silent> <Leader>f :Rg def <C-R><C-W>(<CR>
nnoremap <silent> <Leader>w :Rg <C-R><C-W><CR>
" }}}

" Everything else (not much tho) --------------------------------------{{{
"
"solarized colorscheme setup
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set t_Co=16
" set termguicolors
colorscheme solarized
let g:solarized_italic=0
" colorscheme NeoSolarized
set background=dark

hi! link SignColumn LineNr

"use python in vim editing
:vnoremap <S-Tab> :!python<CR>

"comment lines with (ctrl + /)x2 or with gc (gcc)
vnoremap <c-/> :TComment<cr>

"autoformat setup for php - html data and c,c++
" let g:autoformat_verbosemode=1 " debugging
" noremap <F3> :Neoformat<CR>
noremap <F3> :Autoformat<CR>

let g:formatdef_my_custom_php = '"html-beautify"'
let g:formatters_php = ['my_custom_php']
let g:formatdef_my_custom_c = '"astyle --mode=c --style=kr -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatters_c = ['my_custom_c']
let g:formatdef_my_custom_cpp = '"astyle --mode=c --style=kr -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatters_cpp = ['my_custom_cpp']
" tw option used for python line length with Autoformat plugin
" autocmd FileType python setlocal tw=120

" add margin column for line length
autocmd FileType python set cc=80

"set filename for tmux windows
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window zsh")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" disable cool cursor
" set guicursor=

" let g:neomake_open_list = 1
autocmd! BufWritePost * Neomake
let g:neomake_c_enabled_makers=["gcc"]
let g:neomake_c_gcc_args = ["-Wextra", "-Wall", "-std=c99", "-pedantic", "-Wshadow", "-Wpointer-arith", "-Wcast-qual"]
let g:neomake_cpp_enabled_makers=["gcc"]
let g:neomake_cpp_gcc_args = ["-Wextra", "-Wall", "-pedantic"]

let g:neomake_python_enabled_makers = ["flake8", "pylint"]
let g:neomake_python_flake8_args = ["--max-line-length=119"]

"javascript 
let g:neomake_javascript_enabled_makers = ['eslint']

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

let g:neomake_typescript_enabled_makers = ['tsc']
let g:neomake_html_enabled_makers = []

"save a session
map <F9> :mksession! ~/.nvim_session <cr> " Quick write session with F9
map <F10> :source ~/.nvim_session <cr>     " And load session with F10

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

let g:python_host_prog = "/home/stevanmilic/Applications/neovim-venvs/neovim2/bin/python"
let g:python3_host_prog = "/home/stevanmilic/Applications/neovim-venvs/neovim3/bin/python"

" extended python syntax
let g:python_highlight_all = 1

" disable smartindent for python files, due to the '#' thing
au! FileType python setl nosmartindent

au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

" Enable jedi source debug messages
" let g:deoplete#enable_profile = 1
" let g:deoplete#enable_debug = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#source('jedi', 'debug_enabled', 1)

"no line numbers in terminal mode
au TermOpen * setlocal nonumber norelativenumber

"nerdtree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeWinSize=45

" MatchTagAlways
let g:mta_use_matchparen_group = 0

" jsx in js files
let g:jsx_ext_required = 0

" Gdiff vertical
set diffopt+=vertical

" used for python projects, since then we can search for in hidden files
" let g:ackprg = 'ag --vimgrep --smart-case --skip-vcs-ignores --hidden'
silent! so .local.vim

let g:fugitive_gitlab_domains = ['https://gitlab.tradecore.io/']

" vertical split with new file
nnoremap <leader>v :vnew<CR>

" move tabs left and right
nnoremap <leader>h :tabm -1<CR>
nnoremap <leader>l :tabm +1<CR>

" enable nested neovim in terminal with nvr
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

let g:goyo_width='100%'
let g:goyo_height='100%'

"vim repeat plugin
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

let test#strategy = "neovim"
nmap <Leader>tn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tl :TestLast<CR>
nmap <Leader>tv :TestVisit<CR>
" }}}
