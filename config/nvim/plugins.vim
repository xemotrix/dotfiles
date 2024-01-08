call plug#begin()
    Plug 'nvim-tree/nvim-web-devicons'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'junegunn/vim-easy-align'
    Plug 'ThePrimeagen/harpoon'
    Plug 'folke/trouble.nvim'
    Plug 'mbbill/undotree'

    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'rebelot/kanagawa.nvim'

    Plug 'stevearc/oil.nvim'
    Plug 'jlanzarotta/bufexplorer'

    " Telescope
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'fatih/vim-go'
    Plug 'elixir-editors/vim-elixir'
    Plug 'rhysd/vim-llvm'

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
