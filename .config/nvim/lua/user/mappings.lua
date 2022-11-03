local whichkey = require("which-key")
whichkey.setup({
	ignore_missing = true,
	plugins = {
		marks = false,
		registers = false,
		spelling = {
			enabled = true,
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
	show_help = false,
})

local keymap = {
	j = {
		name = "Debug",
		R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
		E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
		t = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		n = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		s = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		f = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoints" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
		j = { "<cmd>lua require'dap'.goto_()<cr>", "Jump To Cursor" },
	},
	i = {
		name = "Diagnostics",
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace" },
		d = { "<cmd>Trouble document_diagnostics<cr>", "Document" },
	},
	t = {
		name = "Testing",
		n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
		f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
		d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Run Debug" },
		l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
		o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
		a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
		s = { "<cmd>lua require('neotest').summary.open()<cr>", "Summary" },
	},
	s = {
		name = "Buffer",
		u = {
			"<CMD>lua require('close_buffers').delete({type = 'hidden', force = true})<CR>",
			"Close hidden buffers",
		},
		b = { "<CMD>lua require('close_buffers').delete({type = 'this', force = true})<CR>", "Close buffer" },
	},
	g = {
		name = "Git",
		d = { "<CMD>Gdiff<CR>", "Git diff" },
		b = { "<CMD>Git blame<CR>", "Git blame" },
	},
}

whichkey.register(keymap, {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

-- set-up go replace mappings
vim.keymap.set("n", "gr", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
vim.keymap.set("n", "grl", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
vim.keymap.set("x", "gr", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

-- use ufo to close/open all folds
vim.keymap.set("n", "zR", "<cmd> lua require('ufo').openAllFolds()<cr>")
vim.keymap.set("n", "zM", "<cmd> lua require('ufo').closeAllFolds()<cr>")

-- center the search term while iterating
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- additional mappings
vim.cmd([[
  " use space to fold/unfold
  nnoremap <silent> <Space> za
  vnoremap <silent> <Space> za

  " Telescope mappings
  nnoremap <c-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>w <cmd>Telescope grep_string<cr>
  nnoremap <leader>a <cmd>Telescope live_grep<CR>
  nnoremap <silent> <Leader>c <cmd>lua require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="class"})<cr>
  nnoremap <silent> <Leader>f <cmd>lua require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="function"})<cr>
  nnoremap <silent> <leader>x <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ignore_symbols="variable"})<cr>
  nnoremap <silent> <leader>u <cmd>lua require('telescope.builtin').lsp_references({include_declaration=false})<cr>

  " Tab navigation like Firefox.
  nnoremap <silent> <S-tab> :tabprevious<CR>
  " NOTE: Remapping tab also remaps <c-i> this can be fixed by remaping CTRL-n
  " to <tab> to keep the functionality _somewhere_.
  nnoremap <c-n> <tab>
  nnoremap <silent> <tab>   :tabnext<CR>
  nnoremap <silent> <C-t>     :tabnew<CR>
  nnoremap <silent> gb :BufferLinePick<CR>
  nnoremap <silent> <leader>st :windo bd!<CR>
  
  "escape nvim terminal
  tnoremap <Esc> <C-\><C-n>

  "search selected text with //
  vnoremap // y/<C-R>"<CR>
  
  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  
  " nvim tree
  nnoremap <leader>n :NvimTreeToggle<CR>
  
  " vertical split with new file
  nnoremap <leader>v :vnew<CR>
  
  " move tabs left and right
  nnoremap <leader>h :tabm -1<CR>
  nnoremap <leader>l :tabm +1<CR>
]])
