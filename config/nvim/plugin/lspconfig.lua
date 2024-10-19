vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function()
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { buffer = 0 })
		vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { buffer = 0 })
		vim.keymap.set("n", "gP", "<cmd>Lspsaga peek_type_definition<CR>", { buffer = 0 })

		vim.keymap.set("n", "ge", "<cmd>Lspsaga outline<CR>", { buffer = 0 })
		vim.keymap.set("n", "gho", "<cmd>Lspsaga outgoing_calls<CR>", { buffer = 0 })
		vim.keymap.set("n", "ghi", "<cmd>Lspsaga incoming_calls<CR>", { buffer = 0 })
		-- vim.keymap.set("n", "<leader>dj", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = 0 })
		-- vim.keymap.set("n", "<leader>dk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = 0 })
		--
		--
		-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
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
	severity_sort = false,
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
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local enabled_codelens = true
local function setup_code_lens()
	vim.keymap.set("n", "<leader>lc", function()
		enabled_codelens = not enabled_codelens
		if enabled_codelens then
			vim.lsp.codelens.refresh({ bufnr = 0 })
			vim.print("CodeLens enabled")
		else
			vim.lsp.codelens.clear()
			vim.print("CodeLens disabled")
		end
	end)

	vim.keymap.set("n", "<leader>lr", function()
		vim.lsp.codelens.run()
	end)
	vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("lsp-codelens", { clear = true }),
		callback = function()
			if enabled_codelens then
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
	-- elixirls = {
	-- 	on_attach = function(_, _)
	-- 		setup_code_lens()
	-- 	end,
	-- 	settings = {
	-- 		dialyzerEnabled = true,
	-- 		fetchDeps = true,
	-- 		enableTestLenses = true,
	-- 		suggestSpecs = true,
	-- 	},
	-- },
	-- hls = {},
	-- ocamllsp = {
	-- 	on_attach = function(_, _)
	-- 		setup_code_lens()
	-- 	end,
	-- 	settings = {
	-- 		codelens = { enable = true },
	-- 	},
	-- },
	-- pyright = {},
	rust_analyzer = {
		-- on_attach = function(_, bufnr)
		-- 	vim.lsp.inlay_hint.enable(bufnr, true)
		-- end,
		rust_analyzer = {
			inlay_hints = {
				enable = true,
				showParameterNames = true,
				parameterHintsPrefix = "<- ",
				otherHintsPrefix = "=> ",
			},
		},
	},
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
	clojure_lsp = {
		on_attach = function(_, _)
			setup_code_lens()
		end,
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

local lspconfig = require("lspconfig")

lspconfig.gleam.setup({})

lspconfig.ocamllsp.setup({
	on_attach = function(_, _)
		setup_code_lens()
	end,
	settings = {
		codelens = { enable = true },
	},
})

lspconfig.lexical.setup({
	cmd = { "/Users/chema/Documents/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
	root_dir = function(fname)
		return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
	end,
	filetypes = { "elixir", "eelixir", "heex" },
	-- optional settings
	settings = {},
})
