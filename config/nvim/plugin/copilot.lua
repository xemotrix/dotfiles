vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)")

-- require("supermaven-nvim").setup({
-- 	ignore_filetypes = { gitcommit = true },
-- 	log_level = "off",
-- 	disable_inline_completion = false, -- disables inline completion for use with cmp
-- 	disable_keymaps = true, -- disables built in keymaps for more manual control
-- })

-- local complete_line = function()
-- 	local suggestion = require("supermaven-nvim.completion_preview")
-- 	if suggestion.has_suggestion() then
-- 		suggestion.on_accept_suggestion(false)
-- 	else
-- 		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "i", false)
-- 	end
-- end

-- local complete_word = function()
-- 	local suggestion = require("supermaven-nvim.completion_preview")
-- 	if suggestion.has_suggestion() then
-- 		suggestion.on_accept_suggestion_word()
-- 	end
-- end

-- vim.keymap.set("i", "<C-J>", complete_line)
-- vim.keymap.set("i", "<C-h>", complete_word)
