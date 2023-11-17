require("nvim-tree").setup({
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		api.config.mappings.default_on_attach(bufnr)
		-- remove a default, leap uses "s" mapping
		vim.keymap.del("n", "s", { buffer = bufnr })
	end,
	actions = {
		open_file = {
			window_picker = { enable = false },
		},
	},
	view = {
		adaptive_size = true,
		signcolumn = "no",
	},
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		-- map("n", "]c", function()
		-- 	if vim.wo.diff then
		-- 		return "]c"
		-- 	end
		-- 	vim.schedule(function()
		-- 		gs.next_hunk()
		-- 	end)
		-- 	return "<Ignore>"
		-- end, { expr = true })

		-- map("n", "[c", function()
		-- 	if vim.wo.diff then
		-- 		return "[c"
		-- 	end
		-- 	vim.schedule(function()
		-- 		gs.prev_hunk()
		-- 	end)
		-- 	return "<Ignore>"
		-- end, { expr = true })

		-- Actions
		map("n", "<leader>gs", gs.stage_hunk)
		map("n", "<leader>gr", gs.reset_hunk)
		map("v", "<leader>gs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("v", "<leader>gr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("n", "<leader>gS", gs.stage_buffer)
		map("n", "<leader>gu", gs.undo_stage_hunk)
		map("n", "<leader>gR", gs.reset_buffer)
		map("n", "<leader>gp", gs.preview_hunk)
		map("n", "<leader>gd", gs.diffthis)
		map("n", "<leader>gD", function()
			gs.diffthis("~")
		end)
	end,
})

require("blame").setup({})

require("toggleterm").setup({
	size = function(_)
		return vim.o.lines * 0.48
	end,
	open_mapping = "<leader>m",
	hide_numbers = false,
	shade_filetypes = {},
	auto_scroll = false,
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	persist_mode = false,
	insert_mappings = false,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	winbar = { enabled = true },
})

require("trouble").setup({
	auto_preview = false,
})

require("nvim_comment").setup()

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
vim.o.sessionoptions = "curdir,help,tabpages,winsize,winpos"

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
		require("neotest-jest")({}),
		require("neotest-plenary")({}),
		require("neotest-scala")({ framework = "munit", runner = "bloop" }),
		require("neotest-go")({}),
	},
	discovery = {
		enabled = true,
	},
	quickfix = {
		open = false,
	},
	icons = {
		running = "",
		failed = "",
		passed = "",
	},
})

-- ultra fast folds
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require("ufo").setup({
	open_fold_hl_timeout = 0,
	provider_selector = function(_, filetype, _)
		if filetype == "scala" then
			return "lsp"
		end
		return "treesitter"
	end,
})
vim.keymap.set("n", "zR", function()
	require("ufo").openAllFolds()
end)
vim.keymap.set("n", "zM", function()
	require("ufo").closeAllFolds()
end)

-- function HighlightedFoldtext()
-- 	local f = vim.treesitter.foldtext()
-- 	if type(f) == "table" then
-- 		table.insert(f, { " ⋯" })
-- 	end
-- 	return f
-- end
-- vim.wo.foldtext = [[luaeval('HighlightedFoldtext')()]]
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.wo.foldmethod = "expr"

-- require("gitlinker").setup({
-- 	opts = { print_url = false, highlight_duration = 300 },
-- })
require("gitlinker").setup({
	message = false,
})

-- substitute setup
require("substitute").setup({})

require("nvim-surround").setup({
	highlight = {
		duration = 300,
	},
})

require("tmux").setup({
	navigation = {
		-- enables default keybindings (C-hjkl) for normal mode
		enable_default_keybindings = true,
	},
	copy_sync = {
		enable = false,
	},
})

require("flit").setup({
	multiline = false,
	labeled_modes = "nvo",
})

require("mini.ai").setup()

require("flatten").setup({
	window = {
		open = "split",
	},
	block_for = {
		gitcommit = true,
		gitrebase = true,
	},
})

require("git-conflict").setup({
	disable_diagnostics = true,
})
require("dressing").setup({
	select = {
		backend = { "telescope", "nui", "builtin" },
	},
})
vim.cmd([[silent! luafile .local.lua]])
