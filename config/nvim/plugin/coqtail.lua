-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "coq",
-- 	callback = function()
vim.cmd([[ let g:coqtail_nomap = 1 ]])

vim.keymap.set("n", "∆", '<cmd>RocqNext<cr><cmd>RocqJumpToEnd<cr>')
vim.keymap.set("n", "˚", '<cmd>RocqUndo<cr><cmd>RocqJumpToEnd<cr>')
vim.keymap.set("n", "–", '<cmd>RocqToLine<cr><cmd>RocqJumpToEnd<cr>')


-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "coq",
-- 	callback = function()
-- 		vim.cmd([[
--       " Ensure conceal is active
--       setlocal conceallevel=2 concealcursor=nc

--       " Add concealed versions, overriding Coq's own keyword matches
--       syntax match CoqForall /\<forall\>/ conceal cchar=∀ containedin=ALL
--       syntax match CoqExists /\<exists\>/ conceal cchar=∃ containedin=ALL
--     ]])
-- 	end,
-- })
-- vim.cmd([[
--   syntax match coqForall /\<forall\>/ conceal cchar=∀
--   syntax match coqExists /\<exists\>/ conceal cchar=∃
--   syntax match coqArrow /->/ conceal cchar=→
--   syntax match coqImpl /=>/ conceal cchar=⇒
--   syntax match coqNeg /~/ conceal cchar=¬
--   syntax match coqAnd /\<and\>/ conceal cchar=∧
--   syntax match coqOr /\<or\>/ conceal cchar=∨
-- ]])
-- end,
-- })
