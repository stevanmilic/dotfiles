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

-- stylua: ignore start
local keymap = {
	j = {
		name = "Debug",
		R = { function() require'dap'.run_to_cursor() end, "Run to Cursor" },
		E = { function() require'dapui'.eval(vim.fn.input .. '[Expression] > ') end, "Evaluate Input" },
		t = { function() require'dapui'.toggle() end, "Toggle UI" },
		c = { function() require'dap'.continue() end, "Continue" },
		d = { function() require'dap'.disconnect() end, "Disconnect" },
		e = { function() require'dapui'.eval() end, "Evaluate" },
		h = { function() require'dap.ui.widgets'.hover() end, "Hover Variables" },
		n = { function() require'dap'.step_over() end, "Step Over" },
		s = { function() require'dap'.step_into() end, "Step Into" },
		r = { function() require'dap'.repl.toggle() end, "Toggle Repl" },
		b = { function() require'dap'.toggle_breakpoint() end, "Toggle Breakpoint" },
		f = { function() require'dap'.clear_breakpoints() end, "Clear Breakpoints" },
		x = { function() require'dap'.terminate() end, "Terminate" },
		u = { function() require'dap'.step_out() end, "Step Out" },
		j = { function() require'dap'.goto_() end, "Jump To Cursor" },
	},
	i = {
		name = "Diagnostics",
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
	},
	t = {
		name = "Testing",
		n = { function() require('neotest').run.run() end, "Run Nearest" },
		f = { function() require('neotest').run.run(vim.fn.expand('%')) end, "Run File" },
		d = { function() require('neotest').run.run({strategy = 'dap'}) end, "Run Debug" },
		l = { function() require('neotest').run.run_last() end, "Run Last" },
		o = { function() require('neotest').output.open({ enter = true }) end, "Output" },
		a = { function() require('neotest').run.attach() end, "Attach" },
		s = { function() require('neotest').summary.open() end, "Summary" },
		q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
	},
	s = {
		name = "Buffer",
        u = {
          function ()
                    require('close_buffers').delete({type = 'hidden', force = true})
                    require('bufferline.ui').refresh()
                end,
          "Close hidden buffers",
        },
		b = { function() require('close_buffers').delete({type = 'this', force = true}) end, "Close buffer" },
	},
	g = {
		name = "Git",
		d = { "<cmd>Gdiff<CR>", "Git diff" },
		b = { "<cmd>Git blame<CR>", "Git blame" },
	},
    f = {
		name = "Finder",
		w = { function () require("telescope.builtin").grep_string() end, "Find word", },
		a = { function () require("telescope.builtin").live_grep() end, "Find all", },
		c = { function () require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="class"}) end, "Find class", },
		f = { function () require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="function"}) end, "Find function", },
		x = { function () require('telescope.builtin').lsp_dynamic_workspace_symbols({ignore_symbols="variable"}) end, "Find workspace symbol", },
		d = { function () require('telescope.builtin').lsp_document_symbols() end, "Find document symbol", },
		u = { function () require('telescope.builtin').lsp_references({include_declaration=false}) end, "Find references", },
		r = { function () require('telescope.builtin').resume() end, "Resume finder", },
	},
    n = {
        function () require("nvim-tree.api").tree.toggle() end,
        "Nvim tree"
    }
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
vim.keymap.set("n", "gr", function() require('substitute').operator() end, { noremap = true })
vim.keymap.set("n", "grl", function() require('substitute').line() end, { noremap = true })
vim.keymap.set("x", "gr", function() require('substitute').visual() end, { noremap = true })

-- use ufo to close/open all folds
vim.keymap.set("n", "zR", function() require('ufo').openAllFolds() end)
vim.keymap.set("n", "zM", function() require('ufo').closeAllFolds() end)

-- center the search term while iterating
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- stylua: ignore end

-- additional mappings
vim.cmd([[
  " use space to fold/unfold
  nnoremap <silent> <Space> za

  " open nested folds
  nnoremap <leader>z zczA

  " Telescope mappings
  nnoremap <c-p> <cmd>Telescope find_files<cr>

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
  
  " vertical split with new file
  nnoremap <leader>v :vnew<CR>
  
  " move tabs left and right
  nnoremap <leader>h :tabm -1<CR>
  nnoremap <leader>l :tabm +1<CR>
]])
