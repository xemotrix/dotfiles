local ca = require 'idris2.code_action'
local mv = require 'idris2.metavars'
local idris = require 'idris2'

local function custom_on_attach(_client)
	vim.keymap.set("n", "<leader>ic", ca.case_split, { silent = true })
	vim.keymap.set("n", "<leader>iac", ca.add_clause, { silent = true })
	vim.keymap.set("n", "<leader>is", ca.expr_search, { silent = true })
	vim.keymap.set("n", "<leader>ii", idris.show_implicits, { silent = true })
	vim.keymap.set("n", "<leader>ih", idris.hide_implicits, { silent = true })
	vim.keymap.set("n", "<leader>ir", ca.refine_hole, { silent = true })
	vim.keymap.set("n", "<leader>in", mv.goto_next, { silent = true })
	vim.keymap.set("n", "<leader>ip", mv.goto_prev, { silent = true })
	vim.keymap.set("n", "<leader>im", idris.show_machine_names, { silent = true })
end

local function save_hook(_action)
	vim.cmd('silent write')
end

local opts = {
	client = {
		hover = {
			use_split = true, -- Persistent split instead of popups for hover
			split_size = '30%', -- Size of persistent split, if used
			auto_resize_split = true, -- Should resize split to use minimum space
			split_position = 'bottom', -- bottom, top, left or right
			with_history = true, -- Show history of hovers instead of only last
			use_as_popup = false, -- Close the split on cursor movement
		},
	},
	server = {
		on_attach = custom_on_attach,
	},                                  -- Options passed to lspconfig idris3 configuration
	-- autostart_semantic = true,                 -- Should start and refresh semantic highlight automatically
	code_action_post_hook = save_hook,  -- Function to execute after a code action is performed:
	use_default_semantic_hl_groups = true, -- Set default highlight groups for semantic tokens
	-- default_regexp_syntax = true,              -- Enable default highlight groups for traditional syntax based highlighting
}
require('idris2').setup(opts)