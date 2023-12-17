local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

--------------------
-- lsp-config setup
--------------------
local toggle_diagnostics = function()
	if vim.diagnostic.is_disabled() then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
end

local toggle_inlay_hint = function()
	if vim.lsp.inlay_hint.is_enabled() then
		vim.lsp.inlay_hint.enable(0, false)
	else
		vim.lsp.inlay_hint.enable(0, true)
	end
end

-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Reset formatexpr set by lsp module.
	vim.opt_local.formatexpr = ""
	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set("n", "<leader>d", function()
	-- 	require("trouble").open("lsp_definitions")
	-- end, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set({ "v", "n", "i" }, "<c-e>", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>q", toggle_diagnostics, bufopts)

	if client.server_capabilities.inlayHintProvider then
		vim.keymap.set("n", "<leader>p", toggle_inlay_hint)
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

local luv = require("luv")
local is_wsl = luv.os_uname()["release"]:lower():match("microsoft") and true or false

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
if is_wsl then
	capabilities.workspace = {
		didChangeWatchedFiles = { dynamicRegistration = false },
	}
end

require("gx").setup(is_wsl and { open_browser_app = "wslview" } or {})

local servers = {
	"pyright",
	"rust_analyzer",
	"lua_ls",
	"gopls",
	"golangci_lint_ls",
	-- "helm_ls",
	"bufls",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
})
require("mason-nvim-dap").setup({
	ensure_installed = { "python", "delve" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})
require("dap-go").setup()
require("fidget").setup()
require("neodev").setup({
	library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
})
local lspconfig = require("lspconfig")
local enhance_server_settings = {
	pyright = {
		python = {
			analysis = {
				useLibraryCodeForTypes = false,
				diagnosticMode = "openFilesOnly",
				autoSearchPaths = true,
			},
		},
	},
	lua_ls = {
		Lua = {
			hint = {
				enable = true,
			},
		},
	},
	gopls = {
		gopls = {
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = false,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
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

-- Notify in case definition is not found.
local current_definition_handler = vim.lsp.handlers["textDocument/definition"]
vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
	if not result then
		vim.notify("could not find definition", vim.log.levels.WARN)
	end
	current_definition_handler(err, result, ctx, config)
end

-----------------
-- nvim-cmp setup
-- --------------
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local lspkind = require("lspkind")
require("ultimate-autopair").setup({
	fastwarp = {
		map = "<C-s>",
		rmap = "<C-a>",
	},
})

cmp.setup({
	enabled = function()
		return vim.api.nvim_get_option_value("buftype", {}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
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
		["<C-h>"] = cmp.mapping.complete(),
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
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	-- window = {
	-- 	documentation = { border = border },
	-- },
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			preset = "codicons",
		}),
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
		},
	},
	experimental = {
		ghost_text = true,
	},
})
cmp.setup.cmdline(":", {
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
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

-------------------
-- formatting setup
-------------------
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettier" },
		typescriptreact = { "prettier" },
		typescript = { "prettier" },
		go = { "golines" },
		proto = { "buf" },
	},
	format_after_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1000,
		lsp_fallback = true,
	},
})

----------------
-- linting setup
----------------
require("lint").linters_by_ft = {
	proto = { "buf_lint" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
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
local signs = { Error = "●", Warn = "●", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
	virtual_text = { enabled = true },
	sign = { enabled = false },
})

-- Override lsp float border globally
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
-- 	opts = opts or {}
-- 	opts.border = opts.border or border
-- 	return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

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
		{
			elements = { "repl" },
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
})

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

-- dap.listeners.after.event_initialized["dapui_config"] = function()
-- 	dapui.open()
-- end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-------------------------
-- Typescript Tools Setup
-------------------------
require("typescript-tools").setup({ on_attach = on_attach })

---------------------
-- Scala Metals Setup
---------------------
local metals_config = require("metals").bare_config()
metals_config.settings = { showImplicitArguments = true }
metals_config.capabilities = capabilities
metals_config.on_attach = function(client, bufnr)
	on_attach(client, bufnr)
	require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing.
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
