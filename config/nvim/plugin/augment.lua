vim.keymap.set("i", "<C-J>", '<cmd>call augment#Accept(\"\\n\")<cr>')
vim.keymap.set("n", "<leader>ct", '<cmd>Augment chat-toggle<cr>')
vim.keymap.set("n", "<leader>cc", '<cmd>Augment chat<cr>')
vim.keymap.set("v", "<leader>cc", '<cmd>Augment chat<cr>')
vim.keymap.set("n", "<leader>cn", '<cmd>Augment chat-new<cr>')

-- let g:augment_workspace_folders = ['/path/to/project', '~/another-project']
-- vim.g.augment_workspace_folders = { '~/Documents/live-ops' }
