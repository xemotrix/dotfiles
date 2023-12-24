call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sleuth' " Auto tab parameters
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter' " git diff markers
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'junegunn/vim-easy-align'
    " Plug 'itchyny/lightline.vim'
    Plug 'ThePrimeagen/harpoon'

    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'rebelot/kanagawa.nvim'

    Plug 'stevearc/oil.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    Plug 'jlanzarotta/bufexplorer'

    " Telescope
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'fatih/vim-go' " for syntax highlighting and auto fmt

    Plug 'elixir-editors/vim-elixir'

    " CMP
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Copilot
    Plug 'github/copilot.vim'

call plug#end()
