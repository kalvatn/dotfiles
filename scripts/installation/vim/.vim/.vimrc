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
"colorscheme desert
colorscheme default
set background=dark
set cmdheight=2 " height of command bar
set laststatus=2 " always show status
set statusline=\%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l " format statusline
set nu " line numbers
set ruler " show caret position
set nowrap " do not wrap lines by default

" behaviour
set so=10 " lines of view 'context' relative to cursor
set virtualedit=block " allow block selection beyond EOL
" Return to last edit position when opening files
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
        call setpos('.', current_location)
    endfunction
    command! Recfg call ReloadVimConfig()
endif

" indentation
set expandtab " replace tabs with spaces
" number of spaces in one indent
set sw=2
set ts=2
set smarttab " recognizes indentlevel for (de)indenting
set autoindent " retain indentation on next line
set smartindent " autoindenting of blocks

" rules
"set lw=80 " linewidth
"set colorcolumn=150
" highlight only overflowing columns (80 chars)
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)

" filetype detection
set encoding=utf8
filetype plugin on
filetype indent on
" additional filetype detections
au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au BufRead,BufNewFile *.coffee set filetype=coffee
"au BufRead,BufNewFile *.styl set filetype=stylus
"autocmd BufRead,BufNewFile   *.c,*.h,*.java set noic cin noexpandtab
"autocmd BufRead,BufNewFile   *.pl syntax on
autocmd FileType sh,puppet,ruby,xml,html,coffee,styl,js set ts=2 sw=2
autocmd FileType python setlocal ts=4 sw=4


highlight ExtraWhitespace ctermbg=red guibg=red
" the following pattern will match trailing whitespace, except when typing at
" the end of a line.
match ExtraWhitespace /\s\+\%#\@<!$/
" show leading whitespace that includes spaces, and trailing whitespace.
"autocmd BufWinEnter * match ExtraWhitespace /^\s* \s*\|\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/


" use different colorscheme when using vimdiff
if &diff
    "colorscheme darkblue
    colorscheme murphy
endif

" file search/completion
set wildmenu " enable commandlist suggestions

" file name patters to ignore for completion
set wildignore+=*.o,*.out,*.obj,*.class,*.pyc,*.swp
set wildignore+=*.git,*.svn

" ctrl+p
let g:ctrlp_show_hidden = 1 " include hidden files
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  "let g:ctrlp_user_command = 'ag %s -l -i --hidden --nocolor -g ""'
	let g:ctrlp_user_command = 'ag %s -l -i --hidden --nocolor -g ""'
endif

" search settings
set ignorecase
set smartcase
set incsearch
set nohlsearch

" remaps n and N to call custom highlighting function
" https://docs.google.com/file/d/0Bx3f0gFZh5Jqc0MtcUstV3BKdTQ/edit
let hlnext_blinktime = 0.0350
nnoremap <silent> n   n:call HLNext(hlnext_blinktime)<cr>
nnoremap <silent> N   N:call HLNext(hlnext_blinktime)<cr>

function! HLNext (blinktime)
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

" disable for certain files
let g:syntastic_disabled_filetypes = ['java']
"let g:syntastic_java_checker='javac'
let g:syntastic_ignore_files = ['*.java']
" trick syntastic to think that javac checker has already been loaded (to actually not load it)
let g:loaded_syntastic_java_javac_checker = 1

" to explicitly enable/disable files to check
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['foo', 'bar'], 'passive_filetypes': ['java'] }

" set additional linter settings
let g:syntastic_puppet_checkers=['puppet', 'puppetlint']
let g:syntastic_puppet_puppetlint_args=['--no-80chars-check']

" bash
let g:syntastic_sh_checkers=['sh', 'shellcheck', 'bashate']
let g:syntastic_sh_bashate_args=['--ignore E003'] " ignore indent multiple of 4 warning

" python
" disable docstring warn (C0111)
" disable line too long  (C0301)
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_pylint_args=['--disable=C0111,C0301']

" latex
let g:syntastic_tex_checkers       = ['chktex']
" see http://www.nongnu.org/chktex/ChkTeX.pdf
" Warning 1: Command terminated with space
" Warning 2: Non-breaking space (‘˜’) should have been used.
" Warning 3: You should enclose the previous parenthesis with ‘{}’.
" Warning 4: Italic correction (‘\/’) found in non-italic buffer.
" Warning 5: Italic correction (‘\/’) found more than once.
" Warning 6: No italic correction (`\/') found
" Warning 7: Accent command ‘command’ needs use of ‘command’.
" Warning 8: Wrong length of dash may have been used.
" Warning 9: ‘%s’ expected, found ‘%s’.
" Warning 10: Solo ‘%s’ found.
" Warning 11: You should use ‘%s’ to achieve an ellipsis. ('...' should be \ldots)
" Warning 12: Interword spacing (‘\ ’) should perhaps be used.
" Warning 13: Intersentence spacing (‘\@’) should perhaps be used.
" Warning 14: Could not find argument for command.
" Warning 15: No match found for ‘%s’.
" Warning 16: Mathmode still on at end of LaTeX file.
" Warning 17: Number of ‘character’ doesn’t match the number of ‘character’.
" Warning 18: You should use either “ or ” as an alternative to ‘ " ’.
" Warning 29: $\times$ may look prettier here.
let g:syntastic_tex_chktex_args    = '-n1 -n8 -n12 -n29'

let g:syntastic_pug_checkers = ['pug_lint']
let g:syntastic_stylus_checkers = ['stylint']

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
map q :q!

" leader key setup and bindings
let mapleader = ','
let g:mapleader = ','
" reload vimrc
"nnoremap <leader>r :so $MYVIMRC<cr>
nnoremap <leader>r :call ReloadVimConfig()<cr>
" toggle list mode
nnoremap <silent> <leader>l :set list!<cr>
" toggle line numbers
"nnoremap <silent> <leader>n :set nu!<cr>
nnoremap <silent> <leader>n :next<cr>
nnoremap <silent> <leader>N :prev<cr>
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





