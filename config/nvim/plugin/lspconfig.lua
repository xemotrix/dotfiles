-- LSP location lists: drop generated mocks so a symbol with one real
-- implementation jumps straight there instead of prompting.
local ignore_path = "/mocks/"

local function jump_to(item)
	local from = { vim.fn.bufnr("%"), vim.fn.line("."), vim.fn.col("."), 0 }
	vim.fn.settagstack(vim.api.nvim_get_current_win(), {
		items = { { tagname = vim.fn.expand("<cword>"), from = from } },
	}, "t")
	vim.cmd.edit(vim.fn.fnameescape(item.filename))
	vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
	vim.cmd("normal! zz")
end

local function on_list(list)
	local items = vim.tbl_filter(function(item)
		return not string.find(item.filename or "", ignore_path, 1, true)
	end, list.items)

	-- Everything was a mock (e.g. searching from inside one): keep the originals.
	if #items == 0 then
		items = list.items
	end

	if #items == 1 then
		jump_to(items[1])
		return
	end

	local conf = require("telescope.config").values
	require("telescope.pickers")
		.new({}, {
			prompt_title = list.title,
			finder = require("telescope.finders").new_table({
				results = items,
				entry_maker = require("telescope.make_entry").gen_from_quickfix({}),
			}),
			previewer = conf.qflist_previewer({}),
			sorter = conf.generic_sorter({}),
			push_cursor_on_edit = true,
			push_tagstack_on_edit = true,
		})
		:find()
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function()
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "single" })
		end, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation({ on_list = on_list })
		end, { buffer = 0 })
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references(nil, { on_list = on_list })
		end, { buffer = 0 })
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
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
		end, { buffer = 0 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
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
					ST1000 = false, -- missing package comment
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
			tailwindCSS = {
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
		settings = {
			elixirLS = {
				dialyzerEnabled = true,
				fetchDeps = true,
				enableTestLenses = true,
				suggestSpecs = true,
			},
		},
	},
	rust_analyzer = {},
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

-- Native LSP config (nvim 0.11+): nvim-lspconfig only ships the defaults in
-- lsp/*.lua, these get merged on top of them.
vim.lsp.config("*", { capabilities = capabilities })
for name, config in pairs(servers) do
	vim.lsp.config(name, config)
end

require("mason").setup()
local ensure_installed = vim.tbl_keys(servers)
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
-- Enables every mason-installed server.
require("mason-lspconfig").setup()
-- And the ones not installed through mason (gopls, elixirls).
vim.lsp.enable(ensure_installed)
