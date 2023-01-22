require("nvim-tree").setup({
	actions = {
		open_file = {
			window_picker = { enable = false },
		},
	},
	view = {
		adaptive_size = true,
		signcolumn = "no",
		mappings = {
			list = {
				{ key = "s", action = "" },
				{ key = "S", action = "" },
			},
		},
	},
})

require("toggleterm").setup({
	size = function(_)
		return vim.o.lines * 0.45
	end,
	open_mapping = "<leader>m",
	hide_numbers = false,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = false,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
	winbar = {
		enabled = true,
	},
})

require("nvim_comment").setup({
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

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
		require("neotest-jest")({}),
		require("neotest-scala")({ framework = "utest" }),
	},
	discovery = {
		enabled = false,
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
	provider_selector = function(_, _)
		return "treesitter"
	end,
})

require("gitlinker").setup({
	opts = { print_url = false, highlight_duration = 300 },
	mappings = "<leader>y",
})

-- substitute setup
require("substitute").setup({})

require("nvim-surround").setup({
	highlight = {
		duration = 300,
	},
})

-- smart dd
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

require("tmux").setup({
	navigation = {
		-- enables default keybindings (C-hjkl) for normal mode
		enable_default_keybindings = true,
	},
	copy_sync = {
		enable = false,
	},
})

require("delaytrain").setup({
	delay_ms = 1000,
	grace_period = 2,
	keys = {
		["nv"] = { "h", "j", "k", "l" },
	},
})

require("textcase").setup({})

-- neoscroll config
vim.keymap.set({ "n", "v" }, "<ScrollWheelUp>", "<C-y>")
vim.keymap.set({ "n", "v" }, "<ScrollWheelDown>", "<C-e>")
require("neoscroll").setup({
	mappings = { "<C-y>", "<C-e>" },
	respect_scrolloff = true,
	cursor_scrolls_alone = false,
})
require("neoscroll.config").set_mappings({
	["<C-b>"] = { "scroll", { "-0.25", "false", "200" } },
	["<C-f>"] = { "scroll", { "0.25", "false", "200" } },
})

local leap = require("leap")
leap.add_default_mappings()
-- leap.max_phase_one_targets = 0

require("mini.ai").setup()
require("dressing").setup({
	select = {
		-- TODO: Re-enable telescope once it gets to work again.
		backend = { "builtin", "nui" },
	},
})
vim.cmd([[silent! luafile .local.lua]])
