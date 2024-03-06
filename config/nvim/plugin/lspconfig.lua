vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
		-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		-- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		-- map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		-- map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		-- map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		-- map("gr", vim.lsp.buf.lsp_references, "[G]oto [R]eferences")
		-- map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		-- map("gt", vim.lsp.buf.lsp_type_definitions, "Type [D]efinition")
		-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		-- map("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
		-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		-- map("K", vim.lsp.buf.hover, "Hover Documentation")
		-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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
		source = "always",
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
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(c)
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local servers = {
	-- clangd = {},
	gopls = {
		on_attach = function()
			vim.keymap.set("n", "<leader>tc", "<cmd>GoCoverage<CR>")
		end,
	},
	elixirls = {},
	-- hls = {},
	-- ocamllsp = {
	-- 	on_attach = function(client, bufnr)
	-- 		-- code lens
	-- 		if client.resolved_capabilities.code_lens then
	-- 			local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
	-- 			vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
	-- 				group = codelens,
	-- 				callback = function()
	-- 					vim.lsp.codelens.refresh()
	-- 				end,
	-- 				buffer = bufnr,
	-- 			})
	-- 		end
	-- 	end,
	-- 	-- require("virtualtypes").on_attach,
	-- },
	-- pyright = {},
	-- rust_analyzer = {},
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
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

-- require("lspconfig").ocamllsp.setup({ on_attach = require("virtualtypes").on_attach })
