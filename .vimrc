"show some stats
set number
set ruler

"always show tab characters
set listchars=tab:>-
set list

"set encoding
set encoding=utf-8

"search settings
set incsearch
set hlsearch
set showmatch

"line limit settings
set cc=80,100

"last line
set showcmd
set showmode

"backspace settings
set backspace=indent,eol,start

"light mode is evil
set background=dark

syntax enable

filetype plugin indent on

"indentation format settings
set autoindent

"for all leader shortcuts
let mapleader = "\<Space>"

"automatically open some files in hex mode
let g:hexedit_patterns = '*.bin,*.exe,*.so,*.o'

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" show hidden files
let NERDTreeShowHidden=1
