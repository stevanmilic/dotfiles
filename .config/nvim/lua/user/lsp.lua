local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

--------------------
-- lsp-config setup
--------------------
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>e", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(c)
						-- apply whatever logic you want (in this example, we'll only use null-ls)
						return c.name == "null-ls"
					end,
				})
			end,
		})
	end

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "line",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
})

local luadev = require("lua-dev").setup({
	library = { plugins = { "neotest" }, types = true },
	lspconfig = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
})
local lspconfig = require("lspconfig")
local servers = { "pyright", "tsserver" }
local enhance_server_settings = {
	pyright = {
		python = {
			analysis = {
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, server in pairs(servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = enhance_server_settings[server],
	})
end
lspconfig.sumneko_lua.setup(luadev)

-----------------
-- nvim-cmp setup
-- --------------
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
	},
	window = {
		documentation = { border = border },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		}),
	},
})
require("cmp").setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline", keyword_length = 3 },
	}),
})
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "buffer", keyword_length = 3 },
	}),
})

----------------
-- null-ls setup
----------------
local null_ls = require("null-ls")
null_ls.setup({
	on_attach = on_attach,
	debug = true,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		-- null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.buf,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
})

--------------------
-- diagnostics setup
-------------------
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

-- set lsp diagnostics icons
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Override lsp float border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

----------------
-- trouble setup
----------------
require("trouble").setup({})
vim.api.nvim_set_keymap("n", "<leader>iw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>id", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })

------------
-- dap setup
------------
local dap, dapui = require("dap"), require("dapui")
dapui.setup({
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
			},
			size = 40,
			position = "left",
		},
	},
})
dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "RunList",
		metals = {
			runType = "run",
			args = { "check", "examples/list.fuse" },
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "RunOption",
		metals = {
			runType = "run",
			args = { "check", "examples/option.fuse" },
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "RunLambdaCalc",
		metals = {
			runType = "run",
			args = { "check", "examples/lambda_calc.fuse" },
		},
	},
}

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>jc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>jl", [[<cmd>lua require"dap".run_last()<CR>]])
map("n", "<leader>js", [[<cmd>lua require"dap".terminate()<CR>]])
map("n", "<leader>jr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>jk", [[<cmd>lua require("dapui").eval()<CR>]])
map("n", "<leader>jt", [[<cmd>lua require("dapui").toggle()<CR>]])
map("n", "<leader>jb", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>jso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>jsi", [[<cmd>lua require"dap".step_into()<CR>]])

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

---------------------
-- Scala Metals Setup
---------------------
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

local metals_config = require("metals").bare_config()
metals_config.settings = { showImplicitArguments = true }
metals_config.capabilities = capabilities
metals_config.on_attach = function(client, bufnr)
	on_attach(client, bufnr)
	require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
