vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function()
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "single" })
		end, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
		vim.keymap.set("i", "<C-k>", function()
			vim.lsp.buf.signature_help({ border = "single" })
		end, { buffer = 0 })
		vim.keymap.set("n", "<leader>dj", function()
			vim.diagnostic.jump({
				count = 1,
				float = true,
			})
		end, { buffer = 0 })
		vim.keymap.set("n", "<leader>dk", function()
			vim.diagnostic.jump({
				count = -1,
				float = true,
			})
		end, { buffer = 0 })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
		vim.keymap.set("n", "<leader>li", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end)

		vim.keymap.set("n", "<leader>a", vim.diagnostic.open_float, { buffer = 0 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
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
	severity_sort = true,
	float = {
		border = "double",
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

local servers = {
	gopls = {
		cmd = { "/Users/chema/go/bin/gopls" },
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
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
	-- svelte = {},
	ts_ls = {},
	eslint = {},
	cssls = {}, -- scss
	clangd = {},
	tailwindcss = {
		filetypes = {
			"css",
			"scss",
			"sass",
			"html",
			"heex",
			"elixir",
			"eruby",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"rust",
			"svelte",
		},
		settings = {
			experimental = {
				classRegex = {
					[[class= "([^"]*)]],
					[[class: "([^"]*)]],
					'~H""".*class="([^"]*)".*"""',
					'~F""".*class="([^"]*)".*"""',
				},
			},
			includeLanguages = {
				typescript = "javascript",
				typescriptreact = "javascript",
				["html-eex"] = "html",
				["phoenix-heex"] = "html",
				heex = "html",
				eelixir = "html",
				elixir = "html",
				elm = "html",
				erb = "html",
				svelte = "html",
				rust = "html",
			},
			tailwindCSS = {
				validate = true,
				lint = {
					cssConflict = "error",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "error",
				},
			},
		},
		handlers = {
			["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
				vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
			end,
		},
		init_options = {
			userLanguages = {
				elixir = "phoenix-heex",
				eelixir = "phoenix-heex",
				heex = "phoenix-heex",
			},
		},
	},
	elixirls = {
		cmd = { "/Users/chema/elixir-ls/language_server.sh" },
		on_attach = function(_, _) end,
		settings = {
			dialyzerEnabled = true,
			fetchDeps = true,
			enableTestLenses = true,
			suggestSpecs = true,
		},
	},
	rust_analyzer = {
		rust_analyzer = {
			inlay_hints = {
				enable = true,
				showParameterNames = true,
				parameterHintsPrefix = "<- ",
				otherHintsPrefix = "=> ",
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
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

require("mason").setup()
local ensure_installed = vim.tbl_keys(servers or {})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	ensure_installed = ensure_installed,
	automatic_installation = true,
	opts = {},
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
