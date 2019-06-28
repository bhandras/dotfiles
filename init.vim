" Specify a directory for plugins
call plug#begin('~/.nvim/plugged')
 Plug 'tomasr/molokai'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'ctrlpvim/ctrlp.vim'
 Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'Shougo/echodoc.vim'
call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1

" Required for operations modifying multiple buffers like rename.
set hidden

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'cpp': ['clangd'],
    \ 'go': ['gopls'],
    \ 'python': ['pyls'],
    \ }

" Run gofmt and goimports on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

function SetLSPShortcuts()
  nnoremap <leader>l :call LanguageClient_contextMenu()<CR>
  nnoremap <leader>gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>gx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>gh :call LanguageClient#textDocument_hover()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,go,rust,python call SetLSPShortcuts()
augroup END

" always show signcolumn
set signcolumn=yes

" Map leader to ,
let mapleader=','

" Enable mouse
if has('mouse')
	set mouse=a
endif

" Molokai 256 color scheme 
colorscheme molokai
set t_Co=256
let g:rehash256 = 1

set background=dark
" Display the ruler at 81 characters
set colorcolumn=81
" Highlight the current line
set cursorline
" Show the line and column number of the cursor position
set ruler
" Enable syntax highlighting
syntax enable
" Spaces for autoindents
set shiftwidth=2
" Number of spaces a tab counts for
set tabstop=2
" Turn tabs to spaces
set expandtab

" Copy indent from current line when starting a new line
set autoindent
set smartindent

" Show line numbers
set number
" Show file name in title bar
set title 

" Case insensitive matching
set ignorecase
" Do not ignore case if search string contains uppercase characters
set smartcase
" Highlight all search pattern matches
set hlsearch
" Match as you type
set incsearch
"unset the 'last search ipattern' register by hitting 'return'
nnoremap <CR> :noh<CR><CR>

" For OSX clipboard
set clipboard=unnamedplus

" Set list chars (usage :set list/:set nolist)
set list listchars=tab:»\ ,trail:°

" Allow multiple paste
xnoremap p pgvy

" Airline
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>c :bprevious<CR>
nmap <leader>v :bnext<CR>

nnoremap \l :BLines<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :Files<CR>

filetype plugin indent on

" Cursor shape in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
