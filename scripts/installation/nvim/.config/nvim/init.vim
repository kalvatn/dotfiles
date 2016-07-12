" dein plugin manager setup
if &compatible
  set nocompatible
endif

set runtimepath^=/home/kalvatn/dotfiles/scripts/installation/nvim/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.config/nvim/dein'))
call dein#add('Shougo/dein.vim')

" plugins
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" ui
call dein#add('vim-airline/vim-airline')
call dein#add('scrooloose/nerdtree')
call dein#add('ryanoasis/vim-devicons')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
call dein#add('Yggdroot/indentLine')
call dein#add('frankier/neovim-colors-solarized-truecolor-only')

" async
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

" search
call dein#add('troydm/asyncfinder.vim')
call dein#add('Shougo/unite.vim')

" completion
call dein#add('Shougo/deoplete.nvim')


" comments
call dein#add('tpope/vim-commentary')

" surround
call dein#add('tpope/vim-surround')

" git
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('Xuyuanp/nerdtree-git-plugin')

" linting
call dein#add('neomake/neomake')

" install uninstalled plugins on startup
if dein#check_install()
  call dein#install()
endif

call dein#end()
filetype plugin indent on

" end dein plugin manager setup

" functions

" delete trailing whitespace
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

function! AskQuit (msg, options, quit_option)
  if confirm(a:msg, a:options) == a:quit_option
    exit
  endif
endfunction

function! EnsureDirExists ()
  let required_dir = expand("%:h")
  if !isdirectory(required_dir)
    call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
          \       "&Create it\nor &Quit?", 2)

    try
      call mkdir( required_dir, 'p' )
    catch
      call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
    endtry
  endif
endfunction



function! LastPos()
  if &ft =~ 'gitcommit'
    call setpos('.',0)
    return
  endif
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal! g`\"" |
  endif
endfunction

if !exists("*ReloadVimConfig")
  function! ReloadVimConfig ()
    let current_location = getpos('.')
    :so $MYVIMRC
    :echo "reloaded " $MYVIMRC
    call setpos('.', current_location)
  endfunction
  command! Recfg call ReloadVimConfig()
endif

function! HLNext (blinktime)
  set hlsearch
  highlight WhiteOnRed ctermfg=white ctermbg=red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pattern = '\c\%#\%('.@/.'\)'
  let match_indicator = matchadd('WhiteOnRed', target_pattern, 101)
  "set invcursorline " toggle line of match indicator
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(match_indicator)
  "set invcursorline " toggle line of match indicator
  redraw
endfunction

function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

augroup filetypedetect
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" autocmd
autocmd BufWrite * :call DeleteTrailingWS()
augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END
autocmd BufReadPost * :call LastPos()
highlight ExtraWhitespace ctermbg=red guibg=red
" the following pattern will match trailing whitespace, except when typing at
" the end of a line.
match ExtraWhitespace /\s\+\%#\@<!$/
" show leading whitespace that includes spaces, and trailing whitespace.
"autocmd BufWinEnter * match ExtraWhitespace /^\s* \s*\|\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" buffer/file settings
set history=10000
set nobackup
set nowb
set noswapfile
set undofile
set undodir=$HOME/.config/nvim/.undo
" disable creation of .netwrhist files
let g:netrw_dirhistmax = 0

" clipboard
"set clipboard+=unnamed
set clipboard+=unnamedplus
set nopaste

" ui
set noshowmode
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set termguicolors
set background=dark
colorscheme solarized
"colorscheme default


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
set hidden
set ruler
set nowrap
set lazyredraw
set so=10
syntax on

set virtualedit=block

set viminfo^=%

" plugin settings
" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" indentline
let g:indentLine_char='│'

" gitgutter
let g:gitgutter_max_signs = 1000  " default value

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
call deoplete#custom#set('buffer', 'mark', 'buffer')
call deoplete#custom#set('omni', 'mark', 'omni')
call deoplete#custom#set('file', 'mark', 'file')
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.html = ''

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2

" NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1

" unite
let g:unite_data_directory='~/.config/nvim/.cache/unite'
let g:unite_source_history_yank_enable=1
let g:unite_prompt='❯ '
"let g:unite_source_rec_async_command =['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '""', '--ignore', '.git', '--ignore', '*.png', '--ignore', 'lib']
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')
" custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
"nnoremap <silent> <c-p> :Unite -auto-resize -start-insert -direction=botright file_rec/neovim<CR>
nnoremap <silent> <c-p> :Unite -auto-resize -start-insert -direction=botright file_rec/async:!<CR>
"nnoremap <silent> <leader>o :Unite -winwidth=45 -vertical -direction=botright outline<CR>

" mappings/keybindings (https://neovim.io/doc/user/intro.html#key-notation)


" set <leader> key
let mapleader = ','
let g:mapleader = ','


" disable ex mode
nnoremap Q <nop>
" remap q from recording to :q
map q :q!
" remap visual mode EOL to g_ (EOL - newline character)
vmap $ g_
" remap SOL to first non-blank character
map 0 ^

" CTRL+d to delete line in insert mode
inoremap <c-d> <esc>ddi

" align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" toggle comment
nmap <leader>c gcc<cr>
vmap <leader>c gc<cr>

" map CTRL+k/j to move up/down in popupmenu
inoremap <expr><C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<Up>" : "\<C-k>"

" reload vimrc
nnoremap <leader>r :call ReloadVimConfig()<cr>
nnoremap <silent> <leader>l :set list!<cr>
" toggle line numbers
"nnoremap <silent> <leader>n :set nu!<cr>
nnoremap <silent> <leader>n :next<cr>
nnoremap <silent> <leader>N :prev<cr>
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>- :split<cr>
" paste from clipboard
map <silent> <leader>p :set paste<cr>o<Esc>"+]p<Esc> :set nopaste<cr>
map <silent> <leader>t :tabnew<cr>
" quicksave
nnoremap <leader>w :w<cr>
" quickreload
nnoremap <leader>e :e<cr>
" search
nnoremap <leader>s /
" toggle search highlighting
map <silent> <cr> :set nohlsearch!<cr>

" remaps n and N to call custom highlighting function
" https://docs.google.com/file/d/0Bx3f0gFZh5Jqc0MtcUstV3BKdTQ/edit
let hlnext_blinktime = 0.0350
nnoremap <silent> n   n:call HLNext(hlnext_blinktime)<cr>
nnoremap <silent> N   N:call HLNext(hlnext_blinktime)<cr>

nnoremap <silent> r <Nop>
inoremap <silent> <C-r> <Nop>

map <A-1> :NERDTreeToggle<cr>

nnoremap <silent> <leader>u :call dein#update()<CR>


nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

