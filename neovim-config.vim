call plug#begin('~/.local/share/nvim/plugged')

Plug 'ellisonleao/gruvbox.nvim'

call plug#end()

set number			" shows the line number
set termguicolors		" make colors pretty
set cursorline			" highlights the line where the current cursor is
set clipboard+=unnamedplus	" sets the default copy/paste to system clipboard

let g:gruvbox_italic = 1

colorscheme gruvbox
