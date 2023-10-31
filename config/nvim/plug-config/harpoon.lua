global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = true,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },
}

require("harpoon").setup({
    global_settings = global_settings,
    menu = {
        width = vim.api.nvim_win_get_width(0) - 20,
        height = 8,
    }
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "H", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)

