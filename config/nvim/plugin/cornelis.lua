-- let g:cornelis_no_agda_input = 1
vim.cmd([[

let g:cornelis_agda_prefix = "\\"
au BufWritePost *.agda execute "normal! :CornelisLoad\<CR>:CornelisQuestionToMeta\<CR>"

au BufRead,BufNewFile *.agda call AgdaFiletype()
au QuitPre *.agda :CornelisCloseInfoWindows
function! AgdaFiletype()
    nnoremap <buffer> <leader>l   :CornelisLoad<CR>
    nnoremap <buffer> <leader>R   :CornelisRefine<CR>
    nnoremap <buffer> <leader>G   :CornelisGive<CR>
    nnoremap <buffer> <leader>N   :CornelisNormalize<CR>
    nnoremap <buffer> <leader>d   :CornelisMakeCase<CR>
    nnoremap <buffer> <leader>,   :CornelisTypeContext Simplified<CR>
    nnoremap <buffer> <leader>.   :CornelisTypeContextInfer<CR>
    nnoremap <buffer> <leader>n   :CornelisSolve<CR>
    nnoremap <buffer> <leader>a   :CornelisAuto<CR>
    nnoremap <buffer> <leader>gd  :CornelisGoToDefinition<CR>
    nnoremap <buffer> <leader>gp  :CornelisPrevGoal<CR>
    nnoremap <buffer> <leader>gn  :CornelisNextGoal<CR>
    nnoremap <buffer> <C-A>       :CornelisInc<CR>
    nnoremap <buffer> <C-X>       :CornelisDec<CR>
endfunction

function! CornelisLoadWrapper()
  if exists(":CornelisLoad") ==# 2
    CornelisLoad
  endif
endfunction

au BufReadPre *.agda call CornelisLoadWrapper()
au BufReadPre *.lagda* call CornelisLoadWrapper()

let g:cornelis_max_size = 30
let g:cornelis_max_width = 40

]])
