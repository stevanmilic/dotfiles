local whichkey = require("which-key")
whichkey.setup({
	ignore_missing = true,
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
