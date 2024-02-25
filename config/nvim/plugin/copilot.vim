
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

imap <C-L> <Plug>(copilot-next)
imap <C-X> <Plug>(copilot-dismiss)

let g:copilot_chat_view_option = 'split'

vnoremap <silent> <leader>ce y:CopilotChat what does this do?<CR>
vnoremap <silent> <leader>ct y:CopilotChat Briefly explain how the selected code works, then generate unit tests for it.<CR>
