set updatetime=50

syntax on
filetype plugin on  " Will allow scripts to run for specific file types
filetype plugin indent on

set clipboard=unnamed
set number relativenumber
set exrc " To be able to override configurations for each project with a local .nvimrc

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

vnoremap <C-s> :s/<C-r><C-w>//g<Left><Left>
nnoremap <C-s> :%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>

" lolo is lolo lol
" is lolo lol lolo
" lolo is lolo lol
" lolo is lolo lol

" map <leader>tn :tabnew<cr>
" map <leader>tm :tabmove 
" map <leader>tc :tabclose<cr>
" map <leader>to :tabonly<cr>
" nnoremap <silent><leader>h <C-w>h
" nnoremap <silent><leader>j <C-w>j
" nnoremap <silent><leader>k <C-w>k
" nnoremap <silent><leader>l <C-w>l

