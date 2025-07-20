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
set tabstop=2                           " Softtabs, 2 spaces
set shiftwidth=2
set shiftround
set expandtab

" Ensure JavaScript files load
" https://stackoverflow.com/questions/69145357/vim-almost-hangs-with-100-line-typescript-file
set re=2

" Disable swap and backup files
set nobackup
set noswapfile
set nowb

" Indentation settings
set ai                                  " Auto indent
set si                                  " Smart indent
set wrap                                " Wrap lines

" Visual Settings
set noerrorbells                        " No error sounds
set novisualbell                        " No visual bell
set t_vb=                               " No terminal bell
set laststatus=2                        " Always show status line

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
Plug 'pbrisbin/vim-mkdir'
Plug 'preservim/nerdtree'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Ruby/Rails
Plug 'tpope/vim-rails'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Text Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'javascriptreact', 'typescriptreact'] }

call plug#end()

" ===================
" Plugin Configuration
" ===================

" ALE Configuration
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\}

let g:ale_fix_on_save = 1

" vim-test Configuration
let test#strategy = "vimterminal"

" FZF Configuration
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden --ignore .git -g ""'
endif

" Coc Configuration
" https://github.com/neoclide/coc.nvim?tab=readme-ov-file#example-vim-configuration
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Theme Configuration
set background=dark
colorscheme dracula

" ===================
" Key Mappings
" ===================

" Fast save
nnoremap <Leader>w :w!<cr>

" Copy to system clipboard
vnoremap <leader>c "+y

" Fuzzy file search
nnoremap <c-p> :Files<cr>

" Silent searcher
nnoremap \ :Ag<SPACE>

" Window Movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Switch between last two files
nnoremap <Leader><Leader> <C-^>

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

" Rails Scratchpad
nnoremap <silent> <Leader>xx :!bin/rails runner lib/scratchpad.rb<CR>

" Execute current Ruby file
nnoremap <leader>r :w<CR>:!ruby %<CR>

" CTags
set tags=./tags;/
nnoremap <leader>ct :!ctags -R .<CR>

" Spell Checking
map <leader>ss :setlocal spell!<cr>

" Scratchpad
map <leader>x :e ~/scratchpad.md<cr>

" NERDTree
" https://github.com/preservim/nerdtree?tab=readme-ov-file#how-can-i-map-a-specific-key-or-shortcut-to-open-nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Terminal
map <leader>/ :terminal<CR>

" ===================
" Auto Commands
" ===================
"
" Automatically check if files have changed outside of Vim whenever you switch
" to Vim or enter a buffer. This helps prevent editing outdated files by
" silently reloading them if they've been modified elsewhere.
augroup AutoReloadChanged
    autocmd!
    autocmd FocusGained,BufEnter * silent! checktime
augroup END

" Prettier format on save
augroup PrettierFormat
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.md PrettierAsync
augroup END
