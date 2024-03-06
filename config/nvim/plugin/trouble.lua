local trouble = require("trouble")

trouble.setup({
	position = "bottom",
	use_diagnostic_signs = true,
})

vim.keymap.set("n", "<leader>tt", function()
	trouble.toggle()
end)

vim.keymap.set("n", "<leader>td", function()
	trouble.toggle("workspace_diagnostics")
end)

vim.keymap.set("n", "<leader>tb", function()
	trouble.toggle("document_diagnostics")
end)

vim.keymap.set("n", "<leader>tq", function()
	trouble.toggle("quickfix")
end)

vim.keymap.set("n", "<leader>tl", function()
	trouble.toggle("loclist")
end)

vim.keymap.set("n", "<leader>tr", function()
	trouble.toggle("lsp_references")
end)
