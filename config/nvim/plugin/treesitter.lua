-- nvim-treesitter (main branch) only installs parsers; highlighting is
-- started by hand. Parsers are installed on demand when a filetype is opened.
local ts = require("nvim-treesitter")

local ignore_install = { norg = true }
local no_highlight = { go = true }

local available = {}
for _, lang in ipairs(ts.get_available()) do
	available[lang] = true
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang or not available[lang] or ignore_install[lang] then
			return
		end
		ts.install(lang):await(function(err)
			if err or no_highlight[lang] or not vim.api.nvim_buf_is_valid(args.buf) then
				return
			end
			pcall(vim.treesitter.start, args.buf, lang)
		end)
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		include_surrounding_whitespace = false,
	},
})

-- You can use the capture groups defined in textobjects.scm
local select = function(query)
	return function()
		require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
	end
end
vim.keymap.set({ "x", "o" }, "af", select("@function.outer"))
vim.keymap.set({ "x", "o" }, "if", select("@function.inner"))
