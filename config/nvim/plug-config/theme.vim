set termguicolors

" colorscheme catppuccin_mocha
lua require('kanagawa').setup({ compile = true })
colorscheme kanagawa
highlight Normal guibg=none 


let g:lightline = {'colorscheme': 'wombat'}

hi DiagnosticError guifg=#e46876
hi DiagnosticWarn guifg=#ffa066

" let g:lightline = {'colorscheme': 'catppuccin_mocha'}
"
" hi DiagnosticError guifg=#d20f39
" hi DiagnosticWarn guifg=#fe640b
"
" hi Normal guibg=NONE ctermbg=NONE
