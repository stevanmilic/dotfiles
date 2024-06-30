-- Debug mappings
vim.keymap.set("n", "<space>gR", function()
	require("dap").run_to_cursor()
end, { noremap = true, silent = true, desc = "Run to Cursor" })
vim.keymap.set("n", "<space>gE", function()
	require("dapui").eval(vim.fn.input("[Expression]: "))
end, { noremap = true, silent = true, desc = "Evaluate Input" })
vim.keymap.set("n", "<space>gt", function()
	require("dapui").toggle()
end, { noremap = true, silent = true, desc = "Toggle UI" })
vim.keymap.set("n", "<space>gc", function()
	require("dap").continue()
end, { noremap = true, silent = true, desc = "Continue" })
vim.keymap.set("n", "<space>gd", function()
	require("dap").disconnect()
end, { noremap = true, silent = true, desc = "Disconnect" })
vim.keymap.set("n", "<space>ge", function()
	require("dapui").eval()
end, { noremap = true, silent = true, desc = "Evaluate" })
vim.keymap.set("n", "<space>gh", function()
	require("dap.ui.widgets").hover()
end, { noremap = true, silent = true, desc = "Hover Variables" })
vim.keymap.set("n", "<space>gn", function()
	require("dap").step_over()
end, { noremap = true, silent = true, desc = "Step Over" })
vim.keymap.set("n", "<space>gs", function()
	require("dap").step_into()
end, { noremap = true, silent = true, desc = "Step Into" })
vim.keymap.set("n", "<space>gr", function()
	require("dap").repl.toggle()
end, { noremap = true, silent = true, desc = "Toggle Repl" })
vim.keymap.set("n", "<space>gb", function()
	require("dap").toggle_breakpoint()
end, { noremap = true, silent = true, desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<space>gf", function()
	require("dap").clear_breakpoints()
end, { noremap = true, silent = true, desc = "Clear Breakpoints" })
vim.keymap.set("n", "<space>gx", function()
	require("dap").terminate()
end, { noremap = true, silent = true, desc = "Terminate" })
vim.keymap.set("n", "<space>gu", function()
	require("dap").step_out()
end, { noremap = true, silent = true, desc = "Step Out" })
vim.keymap.set("n", "<space>gj", function()
	require("dap").goto_()
end, { noremap = true, silent = true, desc = "Jump To Cursor" })
vim.keymap.set("n", "<space>gv", function()
	require("nvim-dap-virtual-text").toggle()
end, { noremap = true, silent = true, desc = "Toggle Virtual Text" })

-- Diagnostics mappings
vim.keymap.set(
	"n",
	"<leader>iw",
	"<cmd>TroubleToggle workspace_diagnostics<CR>",
	{ noremap = true, silent = true, desc = "Workspace" }
)
vim.keymap.set(
	"n",
	"<leader>id",
	"<cmd>TroubleToggle document_diagnostics<CR>",
	{ noremap = true, silent = true, desc = "Document" }
)

-- Testing mappings
vim.keymap.set("n", "<leader>tn", function()
	require("neotest").run.run()
end, { noremap = true, silent = true, desc = "Run Nearest" })
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { noremap = true, silent = true, desc = "Run File" })
vim.keymap.set("n", "<leader>td", function()
	if vim.bo.filetype == "go" then
		require("dap-go").debug_test()
	else
		require("neotest").run.run({ strategy = "dap" })
	end
end, { noremap = true, silent = true, desc = "Run Debug" })
vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { noremap = true, silent = true, desc = "Run Last" })
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, last_run = true })
end, { noremap = true, silent = true, desc = "Output" })
vim.keymap.set("n", "<leader>ta", function()
	require("neotest").run.attach()
end, { noremap = true, silent = true, desc = "Attach" })
vim.keymap.set("n", "<leader>tx", function()
	require("neotest").run.stop()
end, { noremap = true, silent = true, desc = "Stop" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.open()
end, { noremap = true, silent = true, desc = "Summary" })
vim.keymap.set(
	"n",
	"<leader>tq",
	"<cmd>TroubleToggle quickfix<CR>",
	{ noremap = true, silent = true, desc = "Quickfix" }
)

-- Nvim tree mapping
vim.keymap.set("n", "<leader>n", function()
	require("nvim-tree.api").tree.toggle()
end, { noremap = true, silent = true, desc = "Nvim tree" })

-- Finder mappings
vim.keymap.set("n", "<space>w", function()
	require("telescope.builtin").grep_string()
end, { noremap = true, silent = true, desc = "Find word" })
vim.keymap.set("n", "<space>/", function()
	require("telescope.builtin").live_grep()
end, { noremap = true, silent = true, desc = "Find all" })
vim.keymap.set("n", "<space>f", function()
	require("telescope.builtin").find_files()
end, { noremap = true, silent = true, desc = "Find files" })
vim.keymap.set("n", "<space>b", function()
	require("telescope.builtin").buffers({ sort_mru = true })
end, { noremap = true, silent = true, desc = "Buffers" })
vim.keymap.set("n", "<space>c", function()
	require("telescope.builtin").lsp_workspace_symbols({ query = vim.fn.expand("<cword>"), symbols = "class" })
end, { noremap = true, silent = true, desc = "Find class" })
vim.keymap.set("n", "<space>F", function()
	require("telescope.builtin").lsp_workspace_symbols({
		query = vim.fn.expand("<cword>"),
		symbols = { "function", "method" },
	})
end, { noremap = true, silent = true, desc = "Find function" })
vim.keymap.set("n", "<space>s", function()
	require("telescope.builtin").lsp_document_symbols()
end, { noremap = true, silent = true, desc = "Find document symbol" })
vim.keymap.set("n", "<space>S", function()
	require("telescope.builtin").lsp_dynamic_workspace_symbols({ ignore_symbols = "variable" })
end, { noremap = true, silent = true, desc = "Find workspace symbol" })
vim.keymap.set("n", "<space>u", function()
	require("telescope.builtin").lsp_references({ include_declaration = false })
end, { noremap = true, silent = true, desc = "Find references" })
vim.keymap.set("n", "<space>i", function()
	require("telescope.builtin").lsp_implementations()
end, { noremap = true, silent = true, desc = "Find implementations" })
vim.keymap.set("n", "<space>z", "za", { noremap = true, silent = true, desc = "Resume finder" })

local mini_clue = require("mini.clue")

mini_clue.setup({
	window = {
		delay = 0,
	},
	triggers = {
		{ mode = "n", keys = "<space>" },
	},
	clues = {
		-- Debug
		{ mode = "n", keys = "<space>g", desc = "Debug" },
		{ mode = "n", keys = "<space>gR", desc = "Run to Cursor" },
		{ mode = "n", keys = "<space>gE", desc = "Evaluate Input" },
		{ mode = "n", keys = "<space>gt", desc = "Toggle UI" },
		{ mode = "n", keys = "<space>gc", desc = "Continue" },
		{ mode = "n", keys = "<space>gd", desc = "Disconnect" },
		{ mode = "n", keys = "<space>ge", desc = "Evaluate" },
		{ mode = "n", keys = "<space>gh", desc = "Hover Variables" },
		{ mode = "n", keys = "<space>gn", desc = "Step Over" },
		{ mode = "n", keys = "<space>gs", desc = "Step Into" },
		{ mode = "n", keys = "<space>gr", desc = "Toggle Repl" },
		{ mode = "n", keys = "<space>gb", desc = "Toggle Breakpoint" },
		{ mode = "n", keys = "<space>gf", desc = "Clear Breakpoints" },
		{ mode = "n", keys = "<space>gx", desc = "Terminate" },
		{ mode = "n", keys = "<space>gu", desc = "Step Out" },
		{ mode = "n", keys = "<space>gj", desc = "Jump To Cursor" },
		{ mode = "n", keys = "<space>gv", desc = "Toggle Virtual Text" },
		{ mode = "n", keys = "<space>w", desc = "Find word" },
		{ mode = "n", keys = "<space>/", desc = "Find all" },
		{ mode = "n", keys = "<space>f", desc = "Find files" },
		{ mode = "n", keys = "<space>b", desc = "Buffers" },
		{ mode = "n", keys = "<space>c", desc = "Find class" },
		{ mode = "n", keys = "<space>F", desc = "Find function" },
		{ mode = "n", keys = "<space>s", desc = "Find document symbol" },
		{ mode = "n", keys = "<space>S", desc = "Find workspace symbol" },
		{ mode = "n", keys = "<space>u", desc = "Find references" },
		{ mode = "n", keys = "<space>i", desc = "Find implementations" },
	},
})
local hop = require("hop")
-- Bidirectional leap search for focused windows
vim.keymap.set("n", "gw", hop.hint_words)

-- set-up go replace mappings
vim.keymap.set("n", "gr", function()
	require("substitute").operator()
end, { noremap = true })
vim.keymap.set("n", "grl", function()
	require("substitute").line()
end, { noremap = true })
vim.keymap.set("x", "s", function()
	require("substitute").visual()
end, { noremap = true })

-- center the search term while iterating
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "t", "n" }, "<leader>=", "<cmd>resize +2<CR>")
vim.keymap.set({ "t", "n" }, "<leader>-", "<cmd>resize -2<CR>")
vim.keymap.set({ "t", "n" }, "<leader>;", "<cmd>resize<CR>")

-- git browse
vim.keymap.set(
	{ "n", "v" },
	"<leader>gl",
	"<cmd>GitLink<cr>",
	{ silent = true, noremap = true, desc = "Copy git permlink to clipboard" }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>gL",
	"<cmd>GitLink!<cr>",
	{ silent = true, noremap = true, desc = "Open git permlink in browser" }
)

-- scrolling
vim.keymap.set("n", "<c-u>", "5<c-y>")
vim.keymap.set("n", "<c-d>", "5<c-e>")
vim.keymap.set("n", "<c-b>", "10<c-y>")
vim.keymap.set("n", "<c-f>", "10<c-e>")

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- stylua: ignore end

local gs_cache = require("gitsigns.cache")
local cache = gs_cache.cache

local open_git_commit_diff_with_gitsigns = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local bcache = cache[bufnr]
	if not bcache then
		return
	end

	local lnum = vim.api.nvim_win_get_cursor(0)[1]
	local blame_info = bcache:get_blame(lnum, {})
	if not blame_info then
		vim.notify("blame info not found")
		return
	end

	local commit_sha = blame_info.commit.sha
	local git_show_cmd = "git show " .. commit_sha

	local show_output = vim.fn.systemlist(git_show_cmd)
	if vim.v.shell_error ~= 0 or not show_output then
		vim.notify("error running git command for SHA:", commit_sha)
		return
	end

	-- Open a new buffer for the diff
	vim.api.nvim_command("enew")

	local new_bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(new_bufnr, "buftype", "nofile")
	vim.api.nvim_buf_set_option(new_bufnr, "bufhidden", "hide")
	vim.api.nvim_buf_set_option(new_bufnr, "modifiable", true)

	vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, show_output)
	vim.cmd("setfiletype diff")
end
vim.keymap.set("n", "<leader>go", open_git_commit_diff_with_gitsigns)

-- smart mappings region

-- smart dd
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

local function smart_J()
	vim.cmd("normal! mzJ")

	local col = vim.fn.col(".")
	local context = string.sub(vim.fn.getline("."), col - 1, col + 1)
	if
		context == ") ."
		or context == ") :"
		or context:match("%( .")
		or context:match(". ,")
		or context:match("%w %.")
	then
		vim.cmd("undojoin | normal! x")
	elseif context == ",)" then
		vim.cmd("undojoin | normal! hx")
	end

	vim.cmd("normal! `z")
end
vim.keymap.set("n", "J", smart_J, { noremap = true })

-- additional mappings
vim.cmd([[
  " open nested folds
  nnoremap <leader>z zczA

  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  
  " vertical split with new file
  nnoremap <leader>v :vnew<CR>
  
  " disable command line window default mapping
  nnoremap q: <nop>
]])
