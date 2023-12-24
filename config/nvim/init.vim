source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/plugins.vim

luafile $HOME/.config/nvim/lsp.lua
luafile $HOME/.config/nvim/langs/go.lua
luafile $HOME/.config/nvim/langs/rust.lua
luafile $HOME/.config/nvim/langs/ocaml.lua
luafile $HOME/.config/nvim/langs/python.lua
luafile $HOME/.config/nvim/langs/elixir.lua

luafile $HOME/.config/nvim/plugs/telescope_oil.lua

luafile $HOME/.config/nvim/plug-config/oil.lua
luafile $HOME/.config/nvim/plug-config/cmp.lua
luafile $HOME/.config/nvim/plug-config/harpoon.lua
luafile $HOME/.config/nvim/plug-config/gitsigns.lua
luafile $HOME/.config/nvim/plug-config/treesitter.lua

source $HOME/.config/nvim/plug-config/trouble.vim
source $HOME/.config/nvim/plug-config/copilot.vim
source $HOME/.config/nvim/plug-config/fugitive.vim
source $HOME/.config/nvim/plug-config/telescope.vim
source $HOME/.config/nvim/plug-config/bufexplorer.vim

luafile $HOME/.config/nvim/plug-config/theme.lua

