set nocompatible
scriptencoding utf-8


filetype plugin indent on

set nobackup
set nowb
set noswapfile

" clipboard
set clipboard+=unnamed
" set clipboard+=unnamedplus
set nopaste

set noshowmode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set termguicolors
set background=dark


" https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
" https://deductivelabs.com/en/2016/03/using-true-color-vim-tmux/
" http://ethanschoonover.com/solarized/vim-colors-solarized
colorscheme desert
" let g:solarized_degrade = 1

" search
set ignorecase
set smartcase
set incsearch
set nohlsearch

" general
set ts=2
set sw=2
set expandtab
set smarttab
set autoindent
set smartindent
set wildmenu
set wildmode=full
set wildignore+=*.o,*.out,*.obj,*.class,*.pyc,*.swp
set wildignore+=*.git,*.svn
set laststatus=2
set nu
set list
set hidden
set ruler
set nowrap
set lazyredraw
set so=10
set mouse-=a
syntax on

set virtualedit=block

set viminfo^=%

" set <leader> key
let g:mapleader = ','


" disable ex mode
nnoremap Q <nop>
nnoremap q <nop>
map <leader>q :qall
" remap visual mode EOL to g_ (EOL - newline character)
vmap $ g_
" remap SOL to first non-blank character
map 0 ^

" nnoremap <leader>f za
nnoremap <silent> <leader>f @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <leader>f zf

augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

" CTRL+d to delete line in insert mode
inoremap <c-d> <esc>ddi

" align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" toggle comment
nmap <leader>c gcc
vmap <leader>c gc

" map CTRL+k/j to move up/down in popupmenu
inoremap <expr><C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<Up>" : "\<C-k>"

" reload vimrc
nnoremap <silent> <leader>l :set list!<cr>
" toggle line numbers
"nnoremap <silent> <leader>n :set nu!<cr>
nnoremap <silent> <leader>n :next<cr>
nnoremap <silent> <leader>N :prev<cr>
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>- :split<cr>

" move to last character of pasted content
noremap <silent> p :set paste<cr>o<Esc>gp<Esc>:set nopaste<cr>
noremap <silent> P :set paste<cr>o<Esc>gP<Esc>:set nopaste<cr>
" paste from clipboard
" map <silent> <leader>p :set paste<cr>o<Esc>"+]p<Esc> :set nopaste<cr>
" map <silent> <leader>p :set paste<cr>o<Esc>p<Esc> :set nopaste<cr>
map <silent> <leader>t :tabnew<cr>
" quicksave
nnoremap <leader>w :w<cr>
" quickreload
nnoremap <leader>e :e<cr>
" search
nnoremap <leader>s /
" toggle search highlighting
map <silent> <cr> :set nohlsearch!<cr>

nnoremap <silent> r <Nop>
inoremap <silent> <C-r> <Nop>

