-- background color: 05090f
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
	transparent = true,
	overrides = function(colors) -- add/modify highlights
		local theme = colors.theme
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			TelescopeTitle = { fg = colors.palette.roninYellow, bold = true },
			TelescopePromptBorder = { fg = colors.palette.oldWhite, bg = "none" },
			TelescopeResultsBorder = { fg = colors.palette.oldWhite, bg = "none" },
			TelescopePreviewBorder = { fg = colors.palette.oldWhite, bg = "none" },
		}
	end,
})
vim.cmd.colorscheme("kanagawa-dragon")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
-- vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#e46876" })
-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffa066" })
vim.cmd("highlight Normal guibg=none")
vim.cmd("hi StatusLine ctermbg=none guibg=none ")
vim.cmd("hi DiagnosticError guifg=#e46876")
vim.cmd("hi DiagnosticWarn guifg=#ffa066")

vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#6A9589", bg = "#2B3328" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6A9589", bg = "#2B3328" })

local border = "double"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
})
vim.diagnostic.config({
	float = { border = border },
})
vim.cmd("hi FloatBorder cterm=NONE ctermbg=NONE guibg=NONE")
-- vim.cmd("hi NormalFloat cterm=NONE ctermbg=NONE guibg=NONE")
