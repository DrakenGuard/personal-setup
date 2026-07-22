runtime! defaults.vim

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

call plug#end()

set number		" shows the line number
set termguicolors	" make colors pretty
set cursorline		" highlights the line where the current cursor is

let g:gruvbox_italic = 1

colorscheme gruvbox
