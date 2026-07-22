runtime! defaults.vim

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

call plug#end()

set number
set termguicolors
set cursorline
set clipboard+=unnamedplus

let g:gruvbox_italic = 1

colorscheme gruvbox
