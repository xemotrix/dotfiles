-- background color: 05090f
vim.cmd("set termguicolors")

require('kanagawa').setup({ 
    colors = {
        palette = {},
        theme = {
            all = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    },
    compile = true ,
    transparent = true,
    overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            TelescopeTitle = { fg = colors.palette.roninYellow, bold = true },
            TelescopePromptBorder = { fg =  colors.palette.oldWhite, bg = "none" },
            TelescopeResultsBorder = { fg = colors.palette.oldWhite, bg = "none" },
            TelescopePreviewBorder = { fg = colors.palette.oldWhite, bg = "none" },

        }
    end,
})

vim.cmd("colorscheme kanagawa")
-- vim.cmd("highlight Normal guibg=none") 

vim.cmd("hi StatusLine ctermbg=none guibg=none ")

vim.cmd("hi DiagnosticError guifg=#e46876")
vim.cmd("hi DiagnosticWarn guifg=#ffa066")

-- local _border = "single"
local _border = "double"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)
vim.diagnostic.config{
  float={border=_border}
}
vim.cmd("hi FloatBorder cterm=NONE ctermbg=NONE guibg=NONE")
