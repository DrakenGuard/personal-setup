call plug#begin('~/.local/share/nvim/plugged')

Plug 'ellisonleao/gruvbox.nvim'

call plug#end()

set number
set termguicolors
set cursorline
set clipboard+=unnamedplus

let g:gruvbox_italic = 1

colorscheme gruvbox
