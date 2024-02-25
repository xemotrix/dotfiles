nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>F <cmd>Telescope current_buffer_fuzzy_find<cr>

nnoremap <leader>a <cmd>Telescope diagnostics<cr>

nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>

" vim.keymap.set("n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, { noremap = true, silent = true })
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
