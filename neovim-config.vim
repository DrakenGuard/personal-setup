call plug#begin('~/.local/share/nvim/plugged')

Plug 'ellisonleao/gruvbox.nvim'	" terminal-friendly theme
Plug 'mattn/emmet-vim'		" html+css generator
Plug 'vim-scripts/AutoComplPop'	" shows vim's autocomplete menu while typing

call plug#end()

set number			" shows the line number
set termguicolors		" make colors pretty
set cursorline			" highlights the line where the current cursor is
set clipboard+=unnamedplus	" sets the default copy/paste to system clipboard

" autocomplete options
set complete+=kspell		" adds correct spelling to autocomplete menu
" use :h completeopt to see what they do
set completeopt=menuone,longest,fuzzy,preview
set shortmess+=c 		" removes the status message during autocomplete

let g:gruvbox_italic = 1

colorscheme gruvbox
