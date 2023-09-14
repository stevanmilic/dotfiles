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

require("trouble").setup({})

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
	provider_selector = function(_, _)
		return "treesitter"
	end,
})

require("gitlinker").setup({
	opts = { print_url = false, highlight_duration = 300 },
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

require("delaytrain").setup({
	delay_ms = 1000,
	grace_period = 2,
	keys = {
		["nv"] = { "h", "j", "k", "l" },
	},
})

-- neoscroll config
vim.keymap.set({ "n", "v" }, "<ScrollWheelUp>", "<C-y>")
vim.keymap.set({ "n", "v" }, "<ScrollWheelDown>", "<C-e>")
require("neoscroll").setup({
	mappings = { "<C-y>", "<C-e>" },
	respect_scrolloff = true,
	cursor_scrolls_alone = false,
	pre_hook = function()
		vim.opt.eventignore:append({
			"WinScrolled",
			"CursorMoved",
		})
	end,
	post_hook = function()
		vim.opt.eventignore:remove({
			"WinScrolled",
			"CursorMoved",
		})
	end,
})
require("neoscroll.config").set_mappings({
	["<C-b>"] = { "scroll", { "-0.25", "false", "200" } },
	["<C-f>"] = { "scroll", { "0.25", "false", "200" } },
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

local luv = require("luv")
local is_wsl = luv.os_uname()["release"]:lower():match("microsoft") and true or false
require("gx").setup(is_wsl and { open_browser_app = "wslview" } or {})

require("git-conflict").setup({
	disable_diagnostics = true,
})
require("dressing").setup({
	select = {
		backend = { "telescope", "builtin", "nui" },
	},
})
vim.cmd([[silent! luafile .local.lua]])
