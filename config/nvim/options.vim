set updatetime=10

syntax on
filetype plugin on
filetype plugin indent on

set clipboard=unnamed
set number relativenumber
set exrc

set wrap
set relativenumber
set mouse=a
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes:2
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smartindent
set noshowmode
set incsearch

let mapleader=" "

nnoremap <silent><leader>e :Ex<CR>

nnoremap <silent><C-d> <C-d>zz
nnoremap <silent><C-u> <C-u>zz

nnoremap <silent><C-h> :bprev<CR>
nnoremap <silent><C-l> :bnext<CR>

nnoremap <silent><leader>bc :bw<cr>
nnoremap <silent><leader>bo :%bd\|e#\|bd#<cr>

nnoremap <silent><leader>s :nohlsearch<cr>
nnoremap <silent><leader>S :set hlsearch<CR>

vnoremap <silent>J :m '>+1<CR>gv=gv
vnoremap <silent>K :m '<-2<CR>gv=gv

nnoremap <silent>n nzz
nnoremap <silent>N Nzz

xnoremap <silent><leader>p "_dP

command W w
command Q q
command Wq wq
command WQ wq
