
require'lspconfig'.lmao.setup{
    cmd = { "/Users/chema.rodriguez/Documents/camel/_build/default/bin/main.exe" };
    capabilities = capabilities,
    on_attach = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {buffer=0})
        vim.keymap.set("n", "r", vim.lsp.buf.rename, {buffer=0})
        vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    end,
}
