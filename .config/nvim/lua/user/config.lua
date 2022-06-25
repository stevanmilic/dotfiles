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
  " set cmdheight=0
  set laststatus=0

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
  au BufRead,BufNewFile *.fuse set filetype=fuse
  
  " use space to fold/unfold
  nnoremap <silent> <Space> za
  vnoremap <silent> <Space> za

  autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>
  
  nnoremap <c-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>w <cmd>Telescope grep_string<cr>

  nnoremap <leader>a :Telescope live_grep<CR>
  " nnoremap <silent> <Leader>c :lua require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="class"})<cr>
  " nnoremap <silent> <Leader>f :lua require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="function"})<cr>
  nnoremap <silent> <Leader>c :Telescope grep_string search=class\ <C-R><C-W>(<CR>
  nnoremap <silent> <Leader>f :Telescope grep_string search=def\ <C-R><C-W>(<CR>
  nnoremap <silent> <leader>x :lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ignore_symbols="variable"})<cr>
  nnoremap <silent> <leader>u :lua require('telescope.builtin').lsp_references({include_declaration=false})<cr>
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
    let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  endif
  
  "vim repeat plugin
  silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
  
  let test#strategy = "neovim"
  let test#scala#runner = 'blooptest'
  
  let test#python#runner = 'pytest'
  let test#python#pytest#options = '-s --tb=short'
  
  nmap <Leader>tn :lua require("neotest").run.run()<CR>
  nmap <Leader>tf :lua require("neotest").run.run(vim.fn.expand("%"))<CR>
  nmap <Leader>to :lua require("neotest").output.open({ enter = true })<CR>
  nmap <Leader>td :lua require("neotest").run.run({strategy = "dap"})<CR>
  nmap <Leader>tl :lua require("neotest").run.run_last()<CR>
  nmap <Leader>ta :lua require("neotest").run.attach()<CR>
  nmap <Leader>ts :lua require("neotest").summary.open()<CR>

  " yank duration highlight in ms
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}

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

local toggleterm = require("toggleterm")
toggleterm.setup({
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
        require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
        }),
    },
    icons = {
        running = "",
        failed = "",
        passed = "",
    }
})

-- pretty folds
require("ufo").setup({
    open_fold_hl_timeout = 0,
})

require("gitlinker").setup({
    opts = { print_url = true },
    mappings = "<leader>y"
})

-- substitute setup 
require("substitute").setup({})
vim.keymap.set("n", "gr", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "grl", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("x", "gr", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
