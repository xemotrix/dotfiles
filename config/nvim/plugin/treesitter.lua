---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	sync_install = false,
	auto_install = true,
	ignore_install = { "norg" },
	highlight = {
		enable = true,
		disable = { "go" },
	},
})
