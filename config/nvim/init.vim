source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/plugins.vim

luafile $HOME/.config/nvim/chema.lua

luafile $HOME/.config/nvim/langs/go.lua
luafile $HOME/.config/nvim/langs/rust.lua
luafile $HOME/.config/nvim/langs/python.lua

" luafile $HOME/.config/nvim/plug-config/cmp.lua
luafile $HOME/.config/nvim/plug-config/treesitter.lua
luafile $HOME/.config/nvim/plug-config/hop.lua
" luafile $HOME/.config/nvim/plug-config/theme.lua

source $HOME/.config/nvim/plug-config/theme.vim
source $HOME/.config/nvim/plug-config/telescope.vim
source $HOME/.config/nvim/plug-config/nerdtree.vim
" source $HOME/.config/nvim/plug-config/floaterm.vim
source $HOME/.config/nvim/plug-config/gitgutter.vim
source $HOME/.config/nvim/plug-config/easy_align.vim
source $HOME/.config/nvim/plug-config/tagbar.vim
source $HOME/.config/nvim/plug-config/copilot.vim

"nnoremap <Space> <NOP>
if exists('g:vscode')
    nnoremap <silent> <space> :<C-u>call VSCodeNotify('vspacecode.space')<CR>
endif

