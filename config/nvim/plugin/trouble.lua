vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>tb", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "<leader>tr", function() require("trouble").toggle("lsp_references") end)

require("trouble").setup({
    position = "right",
    width = 80,
    use_diagnostic_signs = true,
})
