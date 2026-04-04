" ============================================================================
" GENERAL SETTINGS
" ============================================================================
" Essential defaults
set nocompatible
filetype plugin indent on

" Recommended to use an autocmd to force 2 spaces for ALL files
autocmd FileType * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

" Specifically for Python (if it still resists)
"autocmd FileType python setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

set expandtab               " Use spaces instead of tabs
set shiftwidth=2            " Size of an indent
set softtabstop=2           " Number of spaces tabs count for while editing
set tabstop=2               " Number of spaces tabs count for
set autoindent              " Copy indent from current line when starting a new one
set smartindent             " Insert indents automatically

" --- UI Visuals ---
set number                  " Show line numbers
set relativenumber          " Show relative line numbers for easier jumping
set cursorline              " Highlight the current horizontal line
set cursorcolumn            " Highlight the current vertical column
set colorcolumn=80          " Draw a vertical ruler at 80 characters
set termguicolors           " Enable 24-bit RGB colors
set signcolumn=yes          " Always show the signcolumn to prevent layout shifts
set showmatch               " Highlight matching brackets
set noshowmode              " Don't show mode (redundant if you use a statusline)

" --- Behavior ---
set mouse=a                 " Enable mouse support in all modes
set clipboard+=unnamedplus  " Use system clipboard for all yank/delete/paste
set ignorecase              " Ignore case in search patterns...
set smartcase               " ...unless search contains an uppercase letter
set undofile                " Maintain undo history between sessions
set scrolloff=8             " Keep 8 lines above/below cursor for context
set updatetime=300          " Faster completion and diagnostic display

" ============================================================================
" KEY MAPS
" ============================================================================

" Set leader key to Space
let mapleader = " "

" Clear search highlighting with Escape
nnoremap <esc> :noh<return><esc>

" Easier window navigation (Ctrl + h,j,k,l)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ============================================================================
" AUTO-COMMANDS
" ============================================================================

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ============================================================================
" AUTO-CLEANUP: Remove Trailing Whitespace
" ============================================================================

" This function deletes all whitespace at the end of every line
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Trigger the function automatically before writing (saving) the buffer
autocmd BufWritePre * call TrimWhitespace()
