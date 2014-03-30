" ==========[ Automatic reloading of .vimrc ]==========
autocmd! BufWritePost .vimrc source %


" ==========[ easy plugin management ]==========
execute pathogen#infect()


" ==========[ Syntax ]==========
syntax on
filetype plugin indent on


" ==========[ Enable smartwrapping ]==========
" No smartwrapping in any of these files...
let g:SW_IGNORE_FILES = '.vimrc,*.vim,*.pl,*.pm,**/bin/**'

set comments-=s1:/*,mb:*,ex:*/      "Don't recognize C comments
set comments-=:XCOMM                "Don't recognize lmake comments
set comments-=:%                    "Don't recognize PostScript comments
set comments-=:#                    "Don't recognize Perl/shell comments
set comments+=fb:*                  "Star-space is a bullet
set comments+=fb:-                  "Dash-space is a bullets

set formatoptions-=cro

set wrapmargin=2                            "Wrap 2 characters from the edge of the window
set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks
set cinwords = ""                           "But not for C-like keywords
inoremap # X<C-H>#|                         "And no magic outdent for comments
nnoremap <silent> >> :call ShiftLine()<CR>| "And no shift magic on comments

function! ShiftLine()
     set nosmartindent
     normal! >>
     set smartindent
endfunction


" ==========[ Set Spaces over Tabs ]==========
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" ==========[ Highlight any line that is longer than 80 Characters ]==========
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)


" ==========[ Make Tabs and trailing spaces visible ]==========
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list


" ==========[ Behave like a mouse ]==========
set mouse=a


" Doesn't work yet the way I want
" ==========[ Open Python Documentation in a new Tab ]==========
"let g:pydoc_open_cmd = 'tabnew'


" ==========[ ctrlp.vim - fuzzy path finder ]==========
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" ==========[ Settings for vim-powerline ]==========
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2


" ==========[ Settings for jedi-vim ]=========
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


" ==========[ Python folding ]==========
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable


" =========[ Moving between windows ]=========
" bind Ctrl+<movement> keys to move around, instead of  Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" ==========[ NERDTree ]==========
nmap <silent> <F2> :execute 'NERDTreeToggle ' . getcwd()<CR>


" ==========[ Swap v and CTRL-V, because Block mode is more useful that Visual mode ]==========
runtime bundle/dragvisuals/dragvisuals.vim
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v


" ==========[ Dragvisuals ]==========
vmap  <expr>  h        DVB_Drag('left')
vmap  <expr>  l        DVB_Drag('right')
vmap  <expr>  j        DVB_Drag('down')
vmap  <expr>  k        DVB_Drag('up')
let g:DVB_TrimWS = 1 " Remove trailing white spaces


" ==========[ map leader key to , ]=========
let mapleader = ","


" ==========[ easier moving between tabs ]==========
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" =========[ Better copy & paste ]=========
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F6>
set clipboard=unnamed


" =========[ There can be only one (one Vim session per file)"]===========
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists *  let v:swapchoice = 'o'
    autocmd SwapExists *  echohl ErrorMsg
    autocmd SwapExists *  echo 'Duplicate edit session (readonly)'
    autocmd SwapExists *  echohl None
    autocmd SwapExists *  call Make_session_finder(expand('<afile>') )
    autocmd SwapExists *  sleep 2
augroup END

function! Make_session_finder (filename)
    exec 'nnoremap ss:!terminal_promote_vim_session ' . a:filename. '<CR>:q!<CR>'
endfunction


" ==========[ Searching ]==========
set hlsearch
set incsearch
set ignorecase
set smartcase

" Removes highlight of your last search
" " ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap  <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" WhiteOnRed doesn't work
" This rewires n and N to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.4)<cr>
"nnoremap <silent> N   N:call HLNext(0.4)<cr>


"function! HLNext (blinktime)
"    let [bufnum, lnum, col, off] = getpos('.')
"    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"    let target_pat = '\c\%#'.@/
"    let ring = matchadd('WhiteOnRed', target_pat, 101)
"    redraw
"    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"    call matchdelete(ring)
"    redraw
"endfunction


" ==========[ Colors ]==========
" mkdir .vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod


" ==========[ some Options ]==========
set title           "Show filename in titlebar of window
set titleold=

set nomore          "Don't page long listings

set autowrite       "Save buffer automatically when changing files
set autoread        "Always reload buffer when external changes detected

set history=700
set undolevels=700

set noshowmode                      "Suppress mode change messages

set updatecount=10                  "Save buffer every 10 chars typed

set textwidth=78                    "Wrap at column 78

set ruler                           "Show cursor location info on status line


" ========[ Indent/outdent current block... ]=========
nmap %% $>i}``
nmap $$ $<i}``


" ==========[ Perl programming support ]==========
" Execute Perl file...
nmap W :!clear;echo;echo;polyperl %;echo;echo;echo<CR>

" Execute Perl file (output to pager)...
nmap E :!polyperl -m %<CR>

" Execute Perl file (in debugger)...
nmap Q :!polyperl -d %<CR>


" Format file with perltidy...
"Nmap ;p [Perltidy the current buffer]  1G!Gperltidy<CR>

" Show what changes perltidy would make...
"Nmap ;pp [Perltidy to the current buffer (as a diff)]  :call Perltidy_diff()<CR>

function! Perltidy_diff ()
    " Work out what the tidied file will be called...
    let perl_file = expand( '%' )
    let tidy_file = perl_file . '.tdy'

    call system( 'perltidy -nst ' . perl_file . ' -o ' . tidy_file )

    " Add the diff to the right of the current window...
    set splitright
    exe ":vertical diffsplit " . tidy_file

    " Clean up the tidied version...
    call delete(tidy_file)
endfunction

