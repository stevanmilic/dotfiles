--------------------
-- lsp-config setup
--------------------
local toggle_diagnostics = function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local toggle_inlay_hint = function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local is_copilot_enabled = true

local toggle_copilot = function()
	local copilot = require("copilot.command")
	if is_copilot_enabled then
		copilot.disable()
		is_copilot_enabled = false
		vim.print("Copilot off 😭")
	else
		copilot.enable()
		is_copilot_enabled = true
		vim.print("Copilot on 🚀")
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
	-- vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>d", require("telescope.builtin").lsp_definitions, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set({ "v", "n", "i" }, "<c-e>", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>q", toggle_diagnostics, bufopts)
	vim.keymap.set("n", "<leader>w", toggle_copilot, bufopts)

	if client.server_capabilities.inlayHintProvider then
		vim.keymap.set("n", "<leader>p", toggle_inlay_hint)
	end
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

local servers = {
	"basedpyright",
	"rust_analyzer",
	"lua_ls",
	"gopls",
	"golangci_lint_ls",
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
	basedpyright = {
		basedpyright = {
			typeCheckingMode = "standard",
		},
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
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
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

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
require("copilot_cmp").setup({ fix_pairs = true })
-- Disable copilot by default.
-- require("copilot.command").disable()

cmp.setup({
	enabled = function()
		return vim.api.nvim_get_option_value("buftype", {}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping.complete(),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
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
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			preset = "codicons",
			symbol_map = { Copilot = "" },
		}),
	},
	sorting = {
		comparators = {
			require("copilot_cmp.comparators").prioritize,
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
		python = { "ruff_format" },
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
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.HINT] = "●",
			[vim.diagnostic.severity.INFO] = "●",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
require("diagflow").setup({
	update_event = { "DiagnosticChanged", "BufReadPost", "CursorMoved" },
	render_event = { "DiagnosticChanged", "CursorMoved", "WinScrolled" },
	format = function(diag)
		if diag.code and diag.code ~= "" then
			return diag.message .. "\n" .. "(" .. diag.code .. ")"
		end
		return diag.message
	end,
	max_width = 100,
	scope = "line",
	padding_top = -1,
})
require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
	virtual_text = { enabled = true },
	sign = { enabled = false },
})

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

require("nvim-dap-virtual-text").setup({
	display_callback = function(variable, buf, stackframe, node, options)
		local value = variable.value
		if value:len() > 50 then
			value = string.sub(variable.value, 1, 50) .. "..."
		end
		if options.virt_text_pos == "inline" then
			return " = " .. value
		else
			return variable.name .. " = " .. value
		end
	end,
})

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

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
metals_config.settings = {
	showImplicitArguments = true,
}
metals_config.init_options.statusBarProvider = "off"
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
