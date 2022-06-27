"show some stats
set number
set ruler

"always show tab characters
set listchars=tab:▸·
set list

"highlight whitespace at the end of line
:highlight ExtraWhitespace ctermbg=darkred guibg=lightred
:match ExtraWhitespace /\s\+$/

"set encoding
set encoding=utf-8

"search settings
set incsearch
set hlsearch
set showmatch

"line limit settings
set cc=80,100
set textwidth=100

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
