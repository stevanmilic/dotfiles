vim.cmd([[
  " enable nested neovim in terminal with nvr
  if has('nvim')
    let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  endif

  au FileType python nnoremap <silent> <Leader>c <cmd>lua require('telescope.builtin').grep_string({search="class " .. vim.fn.expand("<cword>")})<cr>
  au FileType python nnoremap <silent> <Leader>f <cmd>lua require('telescope.builtin').grep_string({search="def " .. vim.fn.expand("<cword>") .. "("})<cr>

  " Autocommand that reloads neovim whenever you save the plugins.lua file
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end

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
