vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
		vim.keymap.set("n", "<leader>li", function()
			vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
		end)
	end,
})

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local enable_codelens = true
local function setup_code_lens()
	vim.keymap.set("n", "<leader>lc", function()
		enable_codelens = not enable_codelens
		if enable_codelens then
			vim.lsp.codelens.refresh({ bufnr = 0 })
		else
			vim.lsp.codelens.clear()
		end
	end)

	vim.keymap.set("n", "<leader>lr", function()
		vim.lsp.codelens.run()
	end)
	vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("lsp-codelens", { clear = true }),
		callback = function()
			if enable_codelens then
				vim.lsp.codelens.refresh({ bufnr = 0 })
			end
		end,
	})
end

local servers = {
	gopls = {
		on_attach = setup_code_lens,
		settings = {
			gopls = {
				codelenses = {
					generate = true,
					gc_details = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					run_govulncheck = true,
				},
				hints = {
					parameterNames = true,
					constantValues = true,
					functionTypeParameters = true,
					compositeLiteralTypes = true,
					compositeLiteralFields = true,
					assignVariableTypes = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
	elixirls = {},
	-- hls = {},
	ocamllsp = {
		on_attach = function(_, _)
			setup_code_lens()
		end,
		settings = {
			codelens = { enable = true },
		},
	},
	-- pyright = {},
	rust_analyzer = {},
	-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

	lua_ls = {
		-- cmd = {...},
		-- filetypes { ...},
		-- capabilities = {},
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
				},
				completion = {
					callSnippet = "Replace",
				},
				hint = {
					enable = true,
				},
			},
		},
	},
}

-- Ensure the servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
require("mason").setup()

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, { "stylua" })
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
require("mason-lspconfig").setup({
	opts = {
		inlay_hints = { enabled = true },
	},
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
