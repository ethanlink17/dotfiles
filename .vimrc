"=====[ Set Font to Courier_New, 9 pt } ========

set guifont=courier_new:h9
set mousemodel=popup_setpos

"=====[ Add mouse functionality ]=====
set mouse=a

"=====[ Copy to clipboard ]=====
set clipboard=unnamed

"====[ Ensure autodoc'd plugins are supported ]===========

runtime plugin/_autodoc.vim

"====[ Work out what kind of file this is ]========

filetype plugin indent on

"=====[ Comments are important ]==================

"highlight Comment term=bold
highlight Comment term=bold ctermfg=white

"=====[ Always show the status line } ============
"
set laststatus=2

"=====[ I Hate Wrapping, Generally } ========

set nowrap

"=======[ Fix smartindent stupidities ]============

set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks

nnoremap <silent> >> :call ShiftLine()<CR>|               "And no shift magic on comments

function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction

"=====[ Set up line numbers and useful stuff]================
set number
"set relativenumber
set showmatch

"=====[ Enable Nmap command for documented mappings ]================

runtime plugin/documap.vim

"=====[ highlight trailing whitespace in red ]================
"have this highlighting not appear whilst you are typing in insert mode
"have the highlighting of whitespace apply when you open new buffers

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"=====[ Set colorscheme ]================


"colorscheme underwater
colorscheme elflord
set background=dark

"=====[ Put all Vim's undo/backup/temp files in one location ]================
" Note this is here: C:\Users\elink\vimtemp
if has('persistent_undo')
    set undodir=~/vimtemp/undo,.
    set undolevels=5000
    set undofile
endif
set backupdir=~/vimtemp/bkup,.
set dir=~/vimtemp//,.

"=====[ set the status line ]================

"set statusline=[%n]\ %<%f\ %([%1*%M%*%R%Y]%)\ \ \ [%{Tlist_Get_Tagname_By_Line()}]\ %=%-19(\LINE\ [%l/%L]\ COL\ [%02c%03V]%)\ %P
let &statusline="%f%< %y[%{&fileencoding}/%{&encoding}/%{&termencoding}][%{&fileformat}](%n)%m%r%w %a%=%b 0x%B  L:%l/%L, C:%-7(%c%V%) %P"

"=====[ Tab handling ]======================================

set tabstop=4      "Tab indentation levels every four columns
set shiftwidth=4   "Indent/outdent by four columns
set expandtab      "Convert all tabs that are typed into spaces
set shiftround     "Always indent/outdent to nearest tabstop
set smarttab       "Use shiftwidths at left margin, tabstops everywhere else


"====[ Edit and auto-update this config file and plugins ]==========

augroup VimReload
autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

nmap <silent>  ;v   [Edit .vimrc]          :next $MYVIMRC<CR>
nmap           ;vv  [Edit .vim/plugin/...] :next ~/.vim/plugin/

"====[ Show partial commands in the last line of the screen ]==========

set showcmd

"====[ Set up smarter search behaviour ]=======================

"Lookahead as search pattern is specified
set incsearch
"Ignore case in all searches...
set ignorecase
"...unless uppercase letters used
set smartcase
"Highlight all matches
set hlsearch

highlight clear Search
highlight       Search    ctermfg=White

"Delete in normal mode to switch off highlighting till next search and clear messages...
nmap <silent> <BS> [Cancel highlighting]  :call HLNextOff() <BAR> :nohlsearch <BAR> :call VG_Show_CursorColumn('off')<CR>

"Double-delete to remove trailing whitespace...
nmap <silent> <BS><BS>  [Remove trailing whitespace] mz:call TrimTrailingWS()<CR>`z

function! TrimTrailingWS ()
    if search('\s\+$', 'cnw')
        :%s/\s\+$//g
    endif
endfunction

"====[ Edit my temporary working files ]====================

nmap tt  [Edit temporary files] :next ~/tmp/temporary_file

"=====[ Quicker access to Ex commands ]==================

nmap ; :
vmap ; :Blockwise<SPACE>

"=====[ Make Visual modes work better ]==================
" Visual Block mode is far more useful that Visual mode (so swap the commands)...
" 3/21/16 - Not sure I like this anymore... backing it out.

"nnoremap v <C-V>
"nnoremap <C-V> v

"vnoremap v <C-V>
"vnoremap <C-V> v

"Square up visual selections...
set virtualedit=block

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

" Make vaa select the entire file...
vmap aa VGo1G

"=====[ Make arrow keys move visual blocks around ]======================
" 3/21/16 - Not really working for me...

"vmap <up>    <Plug>SchleppUp
"vmap <down>  <Plug>SchleppDown
"vmap <left>  <Plug>SchleppLeft
"vmap <right> <Plug>SchleppRight

"vmap D       <Plug>SchleppDupLeft
"vmap <C-D>   <Plug>SchleppDupLeft

"=====[ Toggle syntax highlighting ]==============================

nmap <silent> ;y [Toggle syntax highlighting]
                 \ : if exists("syntax_on") <BAR>
                 \    syntax off <BAR>
                 \ else <BAR>
                 \    syntax enable <BAR>
                 \ endif<CR>

"=====[ syntax highlighting defaults to on ]==============================

syntax on

"=====[ Miscellaneous features (mainly options) ]=====================

set title           "Show filename in titlebar of window
set titleold=

set nomore          "Don't page long listings

set autowrite       "Save buffer automatically when changing files
set autoread        "Always reload buffer when external changes detected

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000

set backspace=indent,eol,start      "BS past autoindents, line boundaries,
                                    "     and even the start of insertion

set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings
                                    "but prefer Unix endings


set wildmode=list:longest,full      "Show list of completions
                                    "  and complete as much as possible,
                                    "  then iterate full completions

set infercase                       "Adjust completions to match case

set noshowmode                      "Suppress mode change messages

set updatecount=10                  "Save buffer every 10 chars typed


" Keycodes and maps timeout in 3/10 sec...
set timeout timeoutlen=300 ttimeoutlen=300

set thesaurus+=~/Documents/thesaurus    "Add thesaurus file for ^X^T
set dictionary+=~/Documents/dictionary  "Add dictionary file for ^X^K


set scrolloff=2                     "Scroll when 2 lines from top/bottom

"====[ Simplify textfile backups ]============================================

" Back up the current file
" 3/21/16 - requires "bak" command which isn't on windows...
nmap BB [Back up current file]  :!bak -q %<CR><CR>:echomsg "Backed up" expand('%')<CR>

"=====[ Add or subtract comments ]===============================

" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd FileType             verilog                           let b:cmt = exists('b:cmt') ? b:cmt : '//'
autocmd FileType             vhdl                              let b:cmt = exists('b:cmt') ? b:cmt : '--'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
nmap <silent> # :call ToggleComment()<CR>j0
vmap <silent> # :call ToggleBlock()<CR>

"====[ Extend a previous match ]=====================================

nnoremap //   /<C-R>/
nnoremap ///  /<C-R>/\<BAR>

"=====[ Make * respect smartcase and also set @/ (to enable 'n' and 'N') ]======

nmap *  :let @/ = '\<'.expand('<cword>').'\>' ==? @/ ? @/ : '\<'.expand('<cword>').'\>'<CR>n

"=====[ Diff against disk ]==========================================

map <silent> zd :silent call DC_DiffChanges()<CR>

" Change the fold marker to something more useful
function! DC_LineNumberOnly ()
    if v:foldstart == 1
        return '(No difference)'
    else
        return 'line ' . v:foldstart . ':'
    endif
endfunction

" Track each buffer's initial state
augroup DC_TrackInitial
    autocmd!
    autocmd BufReadPost,BufNewFile  *   if !exists('b:DC_initial_state')
    autocmd BufReadPost,BufNewFile  *       let b:DC_initial_state = getline(1,'$')
    autocmd BufReadPost,BufNewFile  *   endif
augroup END

highlight DC_DEEMPHASIZED ctermfg=grey

function! DC_DiffChanges ()
    diffthis
    highlight Normal ctermfg=grey
    let initial_state = b:DC_initial_state
    set diffopt=context:1000000,filler,foldcolumn:0
    set fillchars=fold:\
    set foldcolumn=0
    setlocal foldtext=DC_LineNumberOnly()
    aboveleft vnew
    normal 0
    silent call setline(1, initial_state)
    diffthis
    set diffopt=context:1000000,filler,foldcolumn:0
    set fillchars=fold:\
    set foldcolumn=0
    setlocal foldtext=DC_LineNumberOnly()
    nmap <silent><buffer> zd :diffoff<CR>:q!<CR>:set diffopt& fillchars& foldcolumn=0<CR>:set nodiff<CR>:highlight Normal ctermfg=NONE<CR>
endfunction
