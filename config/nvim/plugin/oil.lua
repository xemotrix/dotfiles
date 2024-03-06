require("oil").setup({
	columns = {
		"birthtime",
		"permissions",
		"size",
		"mtime",
		"icon",
	},
	skip_confirm_for_simple_edits = true,
	delete_to_trash = false,
	prompt_save_on_select_new_entry = true,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_vsplit",
		-- ["<C-h>"] = "actions.select_split",
		-- ["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<leader>e"] = "actions.close",
		["<C-c>"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		-- ["`"] = "actions.cd",
		-- ["~"] = "actions.tcd",
		-- ["g."] = "actions.toggle_hidden",
	},
	use_default_keymaps = false,
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
		-- This function defines what is considered a "hidden" file
		is_hidden_file = function(name, bufnr)
			return vim.startswith(name, ".")
		end,
		-- This function defines what will never be shown, even when `show_hidden` is set
		is_always_hidden = function(name, bufnr)
			return false
		end,
	},
})

vim.keymap.set("n", "<leader>e", require("oil").open)
