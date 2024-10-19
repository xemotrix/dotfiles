local global_settings = {
	save_on_toggle = true,
	save_on_change = true,
	excluded_filetypes = { "harpoon" },
}

require("harpoon").setup({
	global_settings = global_settings,
	menu = {
		width = vim.api.nvim_win_get_width(0) - 20,
		height = 8,
	},
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "H", ui.toggle_quick_menu)

local map_nav_file = function(key, num)
	vim.keymap.set("n", key, function()
		ui.nav_file(num)
	end)
end

map_nav_file("<C-h>", 1)
map_nav_file("<C-j>", 2)
map_nav_file("<C-k>", 3)
map_nav_file("<C-l>", 4)
