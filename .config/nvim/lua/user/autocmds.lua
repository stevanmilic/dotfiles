local select_on_complete = function(picker)
	-- if we have exactly one match, select it
	if picker.manager.linked_states.size == 1 then
		require("telescope.actions").select_default(picker.prompt_bufnr)
	end
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		vim.keymap.set("n", "<leader>fc", function()
			require("telescope.builtin").grep_string({
				search = "class " .. vim.fn.expand("<cword>"),
				on_complete = { select_on_complete },
				additional_args = function()
					return { "-g*.py" }
				end,
			})
		end)
		vim.keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").grep_string({
				search = "def " .. vim.fn.expand("<cword>") .. "(",
				on_complete = { select_on_complete },
				additional_args = function()
					return { "-g*.py" }
				end,
			})
		end)
	end,
})

vim.cmd([[
  " enable nested neovim in terminal with nvr
  if has('nvim')
    let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  endif

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
