call plug#begin('~/.local/share/nvim/plugged')

Plug 'ellisonleao/gruvbox.nvim'	" terminal-friendly theme
Plug 'mattn/emmet-vim'		" html+css generator
" programming language parser for enhanced programming experience
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'master'}
" telescope + dependency
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

call plug#end()

let mapleader = " " " change the default <leader> key

" telescope keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set number			" shows the line number
set termguicolors		" make colors pretty
set cursorline			" highlights the line where the current cursor is
set clipboard+=unnamedplus	" sets the default copy/paste to system clipboard
set spell			" adds spelling error checker

" autocomplete options
" use :h completeopt to see what they do
set completeopt=menuone,longest,fuzzy,preview
set shortmess+=c 		" removes the status message during autocomplete

let g:gruvbox_italic = 1

colorscheme gruvbox

" basic setup for telescope
lua << EOF
require('telescope').setup{}
EOF

" basic setup for treesitter
lua << EOF
require('nvim-treesitter.configs').setup {
	ensure_installed = { 
		"html",
		"css",
		"javascript",
		"bash",
		"json",
		"lua",
		"python",
		"c",
	},
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = false },
}
EOF
