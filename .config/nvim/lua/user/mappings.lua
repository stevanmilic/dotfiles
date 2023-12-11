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
        E = { function() require'dapui'.eval(vim.fn.input("[Expression]: ")) end, "Evaluate Input" },
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
        v = { function() require'nvim-dap-virtual-text'.toggle() end, "Toggle Virtual Text" },
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
        d = { function()
            if vim.bo.filetype == 'go' then
                 require('dap-go').debug_test()
            else
                require('neotest').run.run({ strategy = 'dap' })
            end
        end, "Run Debug" },
        l = { function() require('neotest').run.run_last() end, "Run Last" },
        o = { function() require('neotest').output.open({ enter = true, last_run = true }) end, "Output" },
        a = { function() require('neotest').run.attach() end, "Attach" },
        x = { function() require('neotest').run.stop() end, "Stop" },
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
    -- g = {
    --     name = "Git",
    --     b = { "<cmd>ToggleBlame<CR>", "Git blame" },
    -- },
    f = {
        name = "Finder",
        w = { function () require("telescope.builtin").grep_string() end, "Find word", },
        a = { function () require("telescope.builtin").live_grep() end, "Find all", },
        b = { function () require("telescope.builtin").buffers({sort_mru = true}) end, "Buffers", },
        c = { function () require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols="class"}) end, "Find class", },
        f = { function () require('telescope.builtin').lsp_workspace_symbols({query=vim.fn.expand("<cword>"), symbols={"function", "method"}}) end, "Find function", },
        x = { function () require('telescope.builtin').lsp_dynamic_workspace_symbols({ignore_symbols="variable"}) end, "Find workspace symbol", },
        d = { function () require('telescope.builtin').lsp_document_symbols() end, "Find document symbol", },
        u = { function () require('telescope.builtin').lsp_references({include_declaration=false}) end, "Find references", },
        i = { function () require('telescope.builtin').lsp_implementations() end, "Find implementations", },
        r = { function () require('telescope.builtin').resume() end, "Resume finder", },
    },
    n = {
        function () require("nvim-tree.api").tree.toggle() end,
        "Nvim tree"
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

-- treesitter jump to context
vim.keymap.set("n", "[c", require("treesitter-context").go_to_context, { silent = true })

-- Bidirectional leap search for current window
vim.keymap.set("n", "s", function()
	local current_window = vim.fn.win_getid()
	require("leap").leap({ target_windows = { current_window } })
end)

-- Bidirectional leap search for focused windows
vim.keymap.set("n", "gs", function()
	local windows = vim.api.nvim_tabpage_list_wins(0)
	local focused_windows = vim.tbl_filter(function(win)
		return vim.api.nvim_win_get_config(win).focusable
	end, windows)
	require("leap").leap({ target_windows = focused_windows })
end)

-- set-up go replace mappings
vim.keymap.set("n", "gr", function() require('substitute').operator() end, { noremap = true })
vim.keymap.set("n", "grl", function() require('substitute').line() end, { noremap = true })
vim.keymap.set("x", "s", function() require('substitute').visual() end, { noremap = true })

-- center the search term while iterating
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({"t", "n"}, "<leader>=", "<cmd>resize +2<CR>")
vim.keymap.set({"t", "n"}, "<leader>-", "<cmd>resize -2<CR>")
vim.keymap.set({"t", "n"}, "<leader>;", "<cmd>resize<CR>")

vim.keymap.set('n', '<leader>S', function () require("spectre").open() end , { desc = "Open Spectre" })
vim.keymap.set('n', '<leader>sw', function () require("spectre").open_visual({select_word=true}) end, { desc = "Search current word" })

-- git browse
vim.keymap.set(
  {"n", 'v'},
  "<leader>gl",
  "<cmd>GitLink<cr>",
  { silent = true, noremap = true, desc = "Copy git permlink to clipboard" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>gL",
  "<cmd>GitLink!<cr>",
  { silent = true, noremap = true, desc = "Open git permlink in browser" }
)

-- scrolling
vim.keymap.set('n', '<c-u>', '5<c-y>')
vim.keymap.set('n', '<c-d>', '5<c-e>')
vim.keymap.set('n', '<c-b>', '10<c-y>')
vim.keymap.set('n', '<c-f>', '10<c-e>')

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- stylua: ignore end

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

-- auto import
vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })

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
  
  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  
  " vertical split with new file
  nnoremap <leader>v :vnew<CR>
  
  " move tabs left and right
  nnoremap <leader>h :tabm -1<CR>
  nnoremap <leader>l :tabm +1<CR>

  " disable command line window default mapping
  nnoremap q: <nop>
]])
