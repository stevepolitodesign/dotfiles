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
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
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
let g:ale_disable_lsp = 1           " Disable ALE's LSP (Coc handles it)
let g:ale_completion_enabled = 0    " Disable ALE completion (Coc handles it)

function! SetRubyLinter()
  " Look for .rubocop.yml in current directory or parent directories
  let rubocop_config = findfile('.rubocop.yml', '.;')

  if !empty(rubocop_config)
    " Project has RuboCop config - use RuboCop
    let g:ale_linters = {'ruby': ['rubocop']}
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'ruby': ['rubocop'],
    \}
  else
    " No RuboCop config - use StandardRB
    let g:ale_linters = {'ruby': ['standardrb']}
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'ruby': ['standardrb'],
    \}
  endif
endfunction

" Run detection when opening Ruby files
augroup RubyLinterDetection
  autocmd!
  autocmd BufRead,BufNewFile *.rb,*.rake,Gemfile call SetRubyLinter()
augroup END

" Set initial default
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\}
let g:ale_linters = {'ruby': ['rubocop']}

" vim-test Configuration
let test#strategy = "dispatch"

" FZF Configuration
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden --ignore .git -g ""'
endif

" Coc Configuration
" https://github.com/neoclide/coc.nvim?tab=readme-ov-file#example-vim-configuration

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Coc LSP Keybindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)

" Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Testing
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" Rails Scratchpad
nnoremap <silent> <Leader>xx :!bin/rails runner lib/scratchpad.rb<CR>

" Execute current Ruby file
nnoremap <leader>r :w<CR>:!bundle exec ruby %<CR>

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
