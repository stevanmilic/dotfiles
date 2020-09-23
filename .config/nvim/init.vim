" Dein ftw ----------------------------------------------{{{
"
if &compatible
	set nocompatible
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.config/nvim/'))

" neo ftw
call dein#add('Shougo/dein.vim')

" you knoow stuff
call dein#add('junegunn/fzf', {'build': './install --all'})
call dein#add('junegunn/fzf.vim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('lifepillar/vim-solarized8')
" call dein#add('iCyMind/NeoSolarized')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-repeat')
call dein#add('vim-scripts/ReplaceWithRegister')
call dein#add('tpope/vim-surround')
call dein#add('wellle/targets.vim')
call dein#add('zhimsel/vim-stay')
call dein#add('mileszs/ack.vim')
call dein#add('godlygeek/tabular')
call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
call dein#add('Konfekt/FastFold')
call dein#add('scrooloose/nerdtree')
call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})
call dein#add('tpope/vim-abolish')
call dein#add('junegunn/goyo.vim')
call dein#add('janko-m/vim-test')
call dein#add('machakann/vim-highlightedyank')
call dein#add('mg979/vim-xtabline')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
" call dein#add('skywind3000/asyncrun.vim')

" extended auto completion
call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

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
call dein#add('cespare/vim-toml')

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

let mapleader = ","
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
" let g:coc_force_debug = 1

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <leader>d <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>u <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>g  :call CocActionAsync('format')<CR>
nmap <leader>g  :call CocActionAsync('format')<CR>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

" Scroll through preview window.
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci
autocmd BufEnter *.tpl setlocal filetype=htmldjango

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

"comment lines with (ctrl + /)x2 or with gc (gcc)
vnoremap <c-/> :TComment<cr>

"set filename for tmux windows
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window zsh")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

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

let g:python_host_prog = "/home/stevan/Applications/neovim-venvs/neovim2/bin/python"
let g:python3_host_prog = "/home/stevan/Applications/neovim-venvs/neovim3/bin/python"

" extended python syntax
let g:python_highlight_all = 1
let g:python_highlight_space_errors = "0"

" disable smartindent for python files, due to the '#' thing
au! FileType python setl nosmartindent

au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

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

"vim repeat plugin
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

let test#strategy = "neovim"
nmap <Leader>tn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tl :TestLast<CR>
nmap <Leader>tv :TestVisit<CR>

" open terminal in new tab and vsplit
command! -nargs=* T tabnew | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" yank duration highlight in ms
let g:highlightedyank_highlight_duration = 500

" xtabline settings
let g:xtabline_settings = {}
let g:xtabline_lazy = 1
let g:xtabline_settings.show_right_corner = 0
let g:xtabline_settings.current_tab_paths = 0
let g:xtabline_settings.other_tabs_paths = 0
let g:xtabline_settings.indicators = {
      \ 'modified': '●',
      \ 'pinned': '[📌]',
      \}

" airline settings
"
" Disable tabline close button
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamecollapse = 1

let g:airline_extensions = ['branch', 'hunks', 'coc', "term"]

let g:airline_section_c = airline#section#create(['file'])

let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#coc#enabled = 1

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['z', 'warning', 'error']]

let g:airline_theme='solarized'
let g:airline_solarized_dark_inactive_border = 1

" Sections.
let g:webdevicons_enable_airline_tabline = 1

" Fix for terminal theme.
let s:saved_theme = []
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
    for colors in values(a:palette)
        if has_key(colors, 'airline_c') && len(s:saved_theme) ==# 0
            let s:saved_theme = colors.airline_c
        endif
        if has_key(colors, 'airline_term')
            let colors.airline_term = s:saved_theme
        endif
    endfor
endfunction
" }}}
