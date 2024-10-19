vim.cmd("set termguicolors")

require("kanagawa").setup({
	colors = {
		palette = {},
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	compile = true,
	-- transparent = true,
	overrides = function(colors) -- add/modify highlights
		local theme = colors.theme
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			TelescopeTitle = { fg = colors.palette.roninYellow, bold = true },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },

			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

			DiagnosticError = { fg = colors.palette.waveRed },
			DiagnosticWarn = { fg = colors.palette.surimiOrange },
		}
	end,
})

vim.cmd.colorscheme("kanagawa-dragon")

vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#6A9589", bg = "#2B3328" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6A9589", bg = "#1F1F28" })

-- local border = "double"
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
})
