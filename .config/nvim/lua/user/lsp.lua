--------------------
-- lsp-config setup
--------------------
local toggle_diagnostics = function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local toggle_inlay_hint = function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

require("mini.completion").setup()

---Utility for keymap creation.
---@param lhs string
---@param rhs string|function
---@param opts string|table
---@param mode? string|string[]
local function keymap(lhs, rhs, opts, mode)
	opts = type(opts) == "string" and { desc = opts }
		or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
	mode = mode or "n"
	vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps.
---@param keys string
local function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

---Is the completion menu open?
local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

-- server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Reset formatexpr set by lsp module.
	vim.opt_local.formatexpr = ""
	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, bufopts)
	vim.keymap.set("n", "<space>k", vim.lsp.buf.hover, bufopts)
	vim.keymap.set({ "v", "n", "i" }, "<space>a", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>q", toggle_diagnostics, bufopts)

	if client.server_capabilities.inlayHintProvider then
		vim.keymap.set("n", "<space>H", toggle_inlay_hint)
	end

	-- Enable completion and configure keybindings.
	local methods = vim.lsp.protocol.Methods
	if client.supports_method(methods.textDocument_completion) then
		-- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

		-- Use enter to accept completions.
		keymap("<cr>", function()
			return pumvisible() and "<C-y>" or "<cr>"
		end, { expr = true }, "i")

		-- Use slash to dismiss the completion menu.
		keymap("/", function()
			return pumvisible() and "<C-e>" or "/"
		end, { expr = true }, "i")

		-- Use <C-n> to navigate to the next completion or:
		-- - Trigger LSP completion.
		-- - If there's no one, fallback to vanilla omnifunc.
		keymap("<C-n>", function()
			if pumvisible() then
				feedkeys("<C-n>")
			else
				if next(vim.lsp.get_clients({ bufnr = 0 })) then
					vim.lsp.completion.trigger()
				else
					if vim.bo.omnifunc == "" then
						feedkeys("<C-x><C-n>")
					else
						feedkeys("<C-x><C-o>")
					end
				end
			end
		end, "Trigger/select next completion", "i")

		-- Buffer completions.
		keymap("<C-u>", "<C-x><C-n>", { desc = "Buffer completions" }, "i")

		-- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
		-- or select the next completion.
		-- Do something similar with <S-Tab>.
		keymap("<Tab>", function()
			if pumvisible() then
				feedkeys("<C-n>")
			elseif vim.snippet.active() then
				vim.snippet.jump(1)
			else
				feedkeys("<Tab>")
			end
		end, {}, { "i", "s" })
		keymap("<S-Tab>", function()
			if pumvisible() then
				feedkeys("<C-p>")
			elseif vim.snippet.active() then
				vim.snippet.jump(-1)
			else
				feedkeys("<S-Tab>")
			end
		end, {}, { "i", "s" })

		-- Inside a snippet, use backspace to remove the placeholder.
		keymap("<BS>", "<C-o>s", {}, "s")
	end
end

local luv = require("luv")
local is_wsl = luv.os_uname()["release"]:lower():match("microsoft") and true or false

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
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

require("ultimate-autopair").setup({
	fastwarp = {
		map = "<C-s>",
		rmap = "<C-a>",
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
