"start dein setup {
if &compatible
  set nocompatible
endif

set runtimepath^=/home/kalvatn/dotfiles/scripts/installation/nvim/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.config/nvim/dein'))
call dein#add('Shougo/dein.vim')

" plugins
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" ui
call dein#add('vim-airline/vim-airline')
call dein#add('scrooloose/nerdtree')
call dein#add('ryanoasis/vim-devicons')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

" completion
call dein#add('Shougo/deoplete.nvim')


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
"} end dein setup

" buffer/file settings
set history=10000
set nobackup
set nowb
set noswapfile
set undofile
set undodir="$HOME/.config/nvim/.undodir"
let g:netrw_dirhistmax = 0 "disable creation of .netwrhist files


" clipboard
"set clipboard+=unnamed
set clipboard+=unnamedplus
set nopaste

" airline
set noshowmode




" bindings (https://neovim.io/doc/user/intro.html#key-notation)
let mapleader = ','

let g:mapleader = ','
" reload vimrc
nnoremap <leader>r :call ReloadVimConfig()<cr>
" toggle list mode
nnoremap <silent> <leader>l :set list!<cr>
" toggle line numbers
"nnoremap <silent> <leader>n :set nu!<cr>
nnoremap <silent> <leader>n :next<cr>
nnoremap <silent> <leader>N :prev<cr>
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>- :split<cr>
" paste from clipboard
map <silent> <leader>p :set paste<cr>o<Esc>"+]p<Esc> :set nopaste<cr>
map <silent> <leader>t :SyntasticToggleMode<cr>
" quicksave
nnoremap <leader>w :w<cr>
" quickreload
nnoremap <leader>e :e<cr>
" search
nnoremap <leader>s /
" toggle search highlighting
map <silent> <cr> :set nohlsearch!<cr>
" toggle indentlines plugin
"nmap <leader>l :IndentLinesToggle<cr>

map <A-1> :NERDTreeToggle


" functions
" delete trailing whitespace
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()



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

augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

autocmd BufReadPost * :call LastPos()

function! LastPos()
  if &ft =~ 'gitcommit'
    call setpos('.',0)
    return
  endif
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal! g`\"" |
  endif
endfunction
" Remember info about open buffers on close
set viminfo^=%

if !exists("*ReloadVimConfig")
  function! ReloadVimConfig ()
    let current_location = getpos('.')
    :so $MYVIMRC
    :echo "reloaded " $MYVIMRC
    call setpos('.', current_location)
  endfunction
  command! Recfg call ReloadVimConfig()
endif
