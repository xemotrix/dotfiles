require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			height = 0.95,
			width = 0.8,
			-- 	-- other layout configuration here
		},
	},
})

-- Enable telescope extensions, if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>ft", builtin.treesitter)
vim.keymap.set("n", "<leader>fj", builtin.jumplist)
-- vim.keymap.set("n", "<leader>F", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>a", builtin.diagnostics)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
vim.keymap.set("n", "<leader>gc", builtin.git_commits)
vim.keymap.set("n", "<leader>fr", builtin.lsp_references)

vim.keymap.set("n", "<leader>F", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end)

-- vim.keymap.set("n", "<leader>ff", function()
-- 	builtin.find_files(require("telescope.themes").get_ivy({

-- 		-- previewer = false,
-- 	}))
-- end)
