"global settings
set number
set incsearch
set hlsearch
set cc=80
set textwidth=80
set showcmd
set showmode
set showmatch
set backspace=indent,eol,start
set background=dark
 
syntax enable 
 
filetype plugin indent on
 
"indentation format settings
set autoindent
 
"for all leader shortcuts
let mapleader = "\<Space>"
 
"language specific settings
"Webdev (HTML/CSS/JS/TS)
autocmd Filetype javascript,typescript,html,css
	\ setlocal expandtab shiftwidth=4 tabstop=4 
	\ | let g:indentLine_char = '|'

" JSON syntax
autocmd Filetype json
	\ setlocal expandtab shiftwidth=4 tabstop=4
 
"PYTHON
autocmd Filetype python
	\ setlocal shiftwidth=8 tabstop=8 smarttab formatprg=prettier
 
"C/C++
autocmd Filetype c,cpp,rust "consistent with linux kernel style guide
	\ setlocal shiftwidth=8 tabstop=8 list listchars=tab:>-
 
"MARKDOWN
autocmd BufNewFile,BufRead *.md 
	\ setlocal filetype=markdown expandtab shiftwidth=4 tabstop=4
 
 
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install', 'for': ['typescript', 'javascript']}
call plug#end()
