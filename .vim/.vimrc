set secure
" workaround for gnome-terminal sending escape codes on alt+<?> sequences
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
"let c='a'
"while c <= 'z'
"  exec "set <A-".c.">=\e".c
"  exec "imap \e".c." <A-".c.">"
"  let c = nr2char(1+char2nr(c))
"endw
"set timeout ttimeoutlen=50

" load pathogen modules
execute pathogen#infect()
execute pathogen#helptags()

set history=700 " lines to remember
" disable backup files
set nobackup
set nowb
set noswapfile
" copy/paste to/from system clipboard registers
set clipboard+=unnamed
set clipboard+=unnamedplus

" don't redraw while executing macros (good performance config)
set lazyredraw
"set nomodeline "??


" layout/view
colorscheme desert
set background=dark
set cmdheight=2 " height of command bar
set laststatus=2 " always show status
set statusline=\%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l " format statusline
set nu " line numbers
set ruler " show caret position

" behaviour
set so=10 " lines of view 'context' relative to cursor
set virtualedit=block " allow block selection beyond EOL
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

if !exists("*ReloadVimConfig")
    function! ReloadVimConfig ()
        let current_location = getpos('.')
        :so $MYVIMRC
        call setpos('.', current_location)
    endfunction
    command! Recfg call ReloadVimConfig()
endif

" indentation
set expandtab " replace tabs with spaces
" number of spaces in one indent
set shiftwidth=4
set tabstop=4
set smarttab " recognizes indentlevel for (de)indenting
set autoindent " retain indentation on next line
set smartindent " autoindenting of blocks

" rules
"set lw=80 " linewidth
"set colorcolumn=150
" highlight only overflowing columns (80 chars)
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" filetype detection
set encoding=utf8
filetype plugin on
filetype indent on
" additional filetype detections
au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile Vagrantfile set filetype=ruby
"autocmd BufRead,BufNewFile   *.c,*.h,*.java set noic cin noexpandtab
"autocmd BufRead,BufNewFile   *.pl syntax on
autocmd FileType sh,puppet,ruby set ts=2 sw=2

" file name patters to ignore for completion
set wildignore+=*.o,*.out,*.obj,*.class,*.pyc,*.swp
set wildignore+=*.git,*.svn

" search settings
set ignorecase
set smartcase
set incsearch
set hlsearch

" remaps n and N to call custom highlighting function
" https://docs.google.com/file/d/0Bx3f0gFZh5Jqc0MtcUstV3BKdTQ/edit
nnoremap <silent> n   n:call HLNext(0.2)<cr>
nnoremap <silent> N   N:call HLNext(0.2)<cr>

function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pattern = '\c\%#\%('.@/.'\)'
    let match_indicator = matchadd('WhiteOnRed', target_pattern, 101)
    set invcursorline " toggle line of match indicator
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(match_indicator)
    set invcursorline " toggle line of match indicator
    redraw
endfunction

" syntax highlighting
syntax enable

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set additional linter settings
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_puppet_puppetlint_args=['--no-80chars-check']

" bash
"let g:syntastic_sh_checkers=['sh', 'shellcheck', 'checkbashisms', 'bashate']
let g:syntastic_sh_checkers=['sh', 'shellcheck', 'bashate']


" https://github.com/Yggdroot/indentLine
"let g:indentLine_color_term = 239

" none X terminal
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)
"let g:indentLine_leadingSpaceEnabled = 0 " (default: 0)

"""
" CUSTOM MAPPINGS
"""

" remap visual mode EOL to g_ (EOL - newline character)
vmap $ g_
" remap SOL to first non-blank character
map 0 ^
" remap q from recording to :q
map q :q

" leader key setup and bindings
let mapleader = ','
let g:mapleader = ','
" reload vimrc
"nnoremap <leader>r :so $MYVIMRC<cr>
nnoremap <leader>r :call ReloadVimConfig()<cr>
" toggle list mode
nnoremap <silent> <leader>l :set list!<cr>
" toggle line numbers
nnoremap <silent> <leader>n :set nu!<cr>
" paste from clipboard
map <silent> <leader>p :set paste<cr>o<Esc>"+]p<Esc> :set nopaste<cr>
" quicksave
nnoremap <leader>w :w<cr>
" search
nnoremap <leader>s /
" toggle search highlighting
map <silent> <cr> :set nohlsearch!<cr>
" toggle indentlines plugin
"nmap <leader>l :IndentLinesToggle<cr>

" shift lines up/down using alt+j/k
nnoremap <A-j> :m +1<cr>==
nnoremap <A-k> :m -2<cr>==
inoremap <A-j> <Esc>:m .+1<cr>==gi
inoremap <A-k> <Esc>:m .-2<cr>==gi
vnoremap <A-j> :m'>+1<cr>gv=gv
vnoremap <A-k> :m'<-2<cr>gv=gv


" functions
" delete trailing whitespace
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.java :call DeleteTrailingWS()
autocmd BufWrite *.pp :call DeleteTrailingWS()
autocmd BufWrite *.md :call DeleteTrailingWS()
autocmd BufWrite *.sh :call DeleteTrailingWS()
autocmd BufWrite *.*rc :call DeleteTrailingWS()







