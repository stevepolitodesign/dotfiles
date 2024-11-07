" ===================
" General Settings
" ===================
let mapleader = " "                     " Set leader key to space
set nocompatible                        " Don't try to be vi compatible

" Enable filetype detection and plugins
filetype plugin indent on
syntax on

" Basic Settings
set autoindent                          " Minimal automatic indenting for any filetype
set autoread                            " Auto-reload files changed outside vim
set autowrite                           " Automatically write before running commands
set backspace=indent,eol,start          " Intuitive backspace behavior
set hidden                              " Allow hidden buffers
set incsearch                           " Incremental search
set lbr                                 " Linebreak on 80 characters
set mouse=a                             " Enable mouse support
set number                              " Show line numbers
set numberwidth=5                       " Width of line number column
set ruler                               " Show cursor position
set tw=80                               " Text width of 80 characters
set wildmenu                            " Enhanced command-line completion

" Disable swap and backup files
set nobackup
set noswapfile
set nowb

" Indentation settings
set ai                                 " Auto indent
set si                                 " Smart indent
set wrap                               " Wrap lines

" Visual Settings
set noerrorbells                      " No error sounds
set novisualbell                      " No visual bell
set t_vb=                             " No terminal bell
set laststatus=2                      " Always show status line

" ===================
" Plugin Management
" ===================
call plug#begin()

" Interface
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'

" Navigation and Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Development Tools
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'vim-test/vim-test'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Ruby/Rails
Plug 'tpope/vim-rails'

" Text Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'

call plug#end()

" ===================
" Plugin Configuration
" ===================

" ALE Configuration
let g:ale_fix_on_save = 1

" vim-test Configuration
let test#strategy = "vimterminal"

" FZF Configuration
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'
endif

" Theme Configuration
set background=dark
colorscheme dracula

" ===================
" Key Mappings
" ===================

" General
nnoremap <Leader>w :w!<cr>                     " Fast save
vnoremap <leader>c "+y                         " Copy to system clipboard

" FZF
nnoremap <c-p> :Files<cr>                      " Fuzzy file search
nnoremap \ :Ag<SPACE>                          " Silver searcher

" Window Movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Buffer Navigation
nnoremap <Leader><Leader> <C-^>               " Switch between last two files

" Tab Management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Testing
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" CTags
set tags=./tags;/
nnoremap <leader>ct :!ctags -R .<CR>

" Spell Checking
map <leader>ss :setlocal spell!<cr>

" ===================
" Auto Commands
" ===================
augroup AutoReloadChanged
    autocmd!
    autocmd FocusGained,BufEnter * silent! checktime
augroup END

" Enable matchit
runtime macros/matchit.vim
