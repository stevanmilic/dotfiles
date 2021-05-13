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
call dein#add('nvim-lua/popup.nvim')
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('lifepillar/vim-solarized8')
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
call dein#add('tpope/vim-abolish')
call dein#add('junegunn/goyo.vim')
call dein#add('janko-m/vim-test')
call dein#add('machakann/vim-highlightedyank')
call dein#add('akinsho/nvim-bufferline.lua')
call dein#add('moll/vim-bbye')
call dein#add('glepnir/galaxyline.nvim', {'rev': 'main'})
call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': ':TSUpdate'})

" extended auto completion
call dein#add('neoclide/coc.nvim', { 'merged': 0 })

" extended syntax
call dein#add('towolf/vim-helm')
call dein#add('pearofducks/ansible-vim')
call dein#add('gf3/peg.vim')
call dein#add('vim-scripts/ebnf.vim')

" git
call dein#add('tpope/vim-fugitive')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('shumphrey/fugitive-gitlab.vim')
call dein#add('tpope/vim-rhubarb')

" cool icons
call dein#add('kyazdani42/nvim-web-devicons')

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
set foldlevelstart=1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set fillchars=fold:\ 
autocmd FileType vim setlocal fdc=1
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0
autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType go,javascript,javascriptreact setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
autocmd FileType scala setlocal foldmethod=syntax

"no auto fold while typing
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" use space to fold/unfold
nnoremap <Space> za
vnoremap <Space> za

"restore view plugin - restores fold and cursor info
set viewoptions=cursor,slash,unix

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

" }}}

" AutoCompletion section ----------------------------------------------{{{
" if hidden is not set, TextEdit might fail.
" set hidden

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
nmap <silent> <leader>d <Plug>(coc-type-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>u <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>e  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType css set omnifunc=csscomplete#CompleteCSS noci
autocmd BufEnter *.tpl setlocal filetype=htmldjango

" }}}

" Fzf section ----------------------------------------------{{{
" Using lua functions
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({width = 0.5, results_height = 20}))<cr>
nnoremap <leader>w <cmd>lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown({width = 0.5, results_height = 20}))<cr>

nnoremap <leader>a :Telescope grep_string search=
nnoremap <silent> <Leader>c :Telescope grep_string search=class\ <C-R><C-W>(<CR>
nnoremap <silent> <Leader>f :Telescope grep_string search=def\ <C-R><C-W>(<CR>

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
nnoremap <silent> <S-tab> :tabprevious<CR>
nnoremap <silent> <tab>   :tabnext<CR>
nnoremap <silent> <C-t>     :tabnew<CR>
inoremap <silent> <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <silent> <C-tab>   <Esc>:tabnext<CR>i
inoremap <silent> <C-t>     <Esc>:tabnew<CR>
nnoremap <silent> gb :BufferLinePick<CR>
nnoremap <silent> <leader>sb :Bdelete!<CR>
nnoremap <silent> <leader>st :windo bd<CR>

"escape nvim terminal
tnoremap <Esc> <C-\><C-n>

"search selected text with //
vnoremap // y/<C-R>"<CR>

let g:python_host_prog = "/home/stevan/Applications/neovim-venvs/neovim2/bin/python"
let g:python3_host_prog = "/home/stevan/Applications/neovim-venvs/neovim3/bin/python"

" extended python syntax
au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

"no line numbers in terminal mode
au TermOpen * setlocal nonumber norelativenumber

"nerdtree
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeWinSize=45

" Gdiff vertical
set diffopt+=vertical

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
let test#scala#runner = 'blooptest'

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

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  incremental_selection = { enable = true },
  indent = {
    enable = true
  },
}

require'bufferline'.setup{
  options = {
    view = "default",
    show_buffer_close_icons = false,
    show_close_icon = false,
  }
}

local transform_mod = require('telescope.actions.mt').transform_mod
local actions = require('telescope.actions')

require'telescope'.setup{
  defaults = {
    prompt_prefix = "🔍",
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-b>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    },
  }
}

local gl = require('galaxyline')
local colors = {
  bg = '#073642',
  yellow = '#b58900',
  cyan = '#2aa198',
  darkblue = '#081633',
  green = '#859900',
  orange = '#cb4b16',
  purple = '#5d4d7a',
  magenta = '#d33682',
  grey = '#c0c0c0',
  blue = '#268bd2',
  red = '#dc322f'
}
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue,colors.bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                          [''] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[''] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = {colors.red,colors.bg,'bold'},
  },
}
gls.left[3] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg}
  }
}
gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}

gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta,colors.bg,'bold'}
  }
}

gls.left[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

gls.left[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
}


gls.right[1] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[3] = {
  RainbowBlue = {
    provider = function() return '  ▊' end,
    highlight = {colors.blue,colors.bg}
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
EOF

silent! so .local.vim

" }}}
