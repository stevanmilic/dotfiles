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
  set diffopt+=vertical,linematch:60
  set formatexpr=
  set updatetime=100
  set splitkeep=cursor
  set nolazyredraw
  set jumpoptions=stack
  set switchbuf=usetab,newtab

  syntax enable "syntax highlight enebled
  set termguicolors

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
]])

-- vim.wo.foldmethod = "expr"
-- vim.wo.foldtext = ""
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.g.mapleader = ","
