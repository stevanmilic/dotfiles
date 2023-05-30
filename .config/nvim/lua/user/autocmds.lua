local select_on_complete = function(picker)
	-- remove this on_complete callback
	picker:clear_completion_callbacks()
	-- if we have exactly one match, select it
	if picker.manager.linked_states.size == 1 then
		require("telescope.actions").select_default(picker.prompt_bufnr)
	end
end
local copy_import_statement = function()
	local file_name = vim.fn.expand("%:~:.")
	local module_name = file_name:gsub(".py", ""):gsub("/", ".")
	local symbol_name = vim.fn.expand("<cword>")
	local import_statement = "from " .. module_name .. " import " .. symbol_name
	vim.notify(import_statement)
	vim.api.nvim_command("let @+ = '" .. import_statement .. "'")
end
local copy_symbol_path = function()
	local file_name = vim.fn.expand("%:~:.")
	local module_name = file_name:gsub(".py", ""):gsub("/", ".")
	local symbol_name = vim.fn.expand("<cword>")
	local symbol_path = module_name .. "." .. symbol_name
	vim.notify(symbol_path)
	vim.api.nvim_command("let @+ = '" .. symbol_path .. "'")
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
		vim.keymap.set("n", "<leader>ys", copy_import_statement)
		vim.keymap.set("n", "<leader>yp", copy_symbol_path)
	end,
})

local neotest_group = vim.api.nvim_create_augroup("NeotestConfig", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "neotest-output", "neotest-attach" },
	group = neotest_group,
	callback = function(opts)
		vim.keymap.set("n", "q", function()
			pcall(vim.api.nvim_win_close, 0, true)
		end, { buffer = opts.buf })
	end,
})

vim.cmd([[
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
