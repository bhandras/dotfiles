" Specify a directory for plugins
call plug#begin('~/.nvim/plugged')
 Plug 'morhetz/gruvbox'
 Plug 'NLKNguyen/papercolor-theme'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'junegunn/rainbow_parentheses.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'

 Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 " Plug 'neovim/nvim-lsp'
 " Plug 'Shougo/deoplete-lsp'
 Plug 'Shougo/echodoc'

 Plug 'scrooloose/nerdtree'
 Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
 Plug 'tyru/current-func-info.vim'
 Plug 'majutsushi/tagbar'
 Plug 'tpope/vim-fugitive'
 Plug 'Valloric/MatchTagAlways'

 Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
 " Plug 'sbdchd/neoformat'
call plug#end()

" set up folding
set foldmethod=indent
set nofoldenable
set foldlevel=99
nnoremap <space> za

" Open tagbar at the left
let g:tagbar_left=1

let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_start_length = 1

" Required for operations modifying multiple buffers like rename.
set hidden

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

let g:go_def_mapping_enabled = 0
let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1


" lua require'nvim_lsp'.gopls.setup{}
let g:fzf_preview_window = 'right:50%'
" let g:LanguageClient_fzfOptions = fzf#vim#with_preview().options
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'go': ['gopls'],
    \ 'python': ['pyls'],
    \ }

function SetLSPShortcuts()
  " nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
  " nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
  " nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  " nnoremap <silent> gx    <cmd>lua vim.lsp.buf.references()<CR>
  " nnoremap <silent> gF    <cmd>lua vim.lsp.buf.formatting()<CR>

  nnoremap <silent> <leader>l :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> gx :call LanguageClient#textDocument_references()<CR>
  nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,go,rust,python call SetLSPShortcuts()
augroup END

let g:neoformat_enabled_sql = ['pg_format']
let g:neoformat_sql_sqlformat = {
            \ 'exe': 'pg_format',
            \ 'args': ['-'],
            \ 'stdin': 1,
            \ }

" always show signcolumn
set signcolumn=yes

" Map leader to ,
let mapleader=','
" let maplocalleader="\<space>"

" Enable mouse
if has('mouse')
	set mouse=a
endif

" Gruvbox
let g:gruvbox_italic=1
let g:gruvbox_invert_selection=0
colorscheme gruvbox
set background=dark
" colorscheme PaperColor
" set background=light
"
" NeoVim colors
set termguicolors

" Display the ruler at 81 characters
set colorcolumn=81
" Highlight the current line
set cursorline
" Show the line and column number of the cursor position
set ruler
" Enable syntax highlighting
syntax enable
" Spaces for autoindents
set shiftwidth=4
" Number of spaces a tab counts for
set tabstop=8
" Turn tabs to spaces
set expandtab

" Copy indent from current line when starting a new line
set autoindent
set smartindent

" Show hybrid relative line numbers
set nu rnu
set numberwidth=2
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

" clipboard
set clipboard=unnamedplus

" Set list chars (usage :set list/:set nolist)
" set list listchars=tab:»\ ,trail:°

" Allow multiple paste
xnoremap p pgvy

" Airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tagbar#flags = 'f'


nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

map <leader>e :NERDTreeToggle<CR>
map <leader>s :TagbarToggle<CR>

nnoremap \l :BLines<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>c :Commits<CR>
" nnoremap <leader>nf :Neoformat<cr>

filetype plugin indent on

" Cursor shape in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"

" show current function name
nnoremap <leader>n :echo cfi#format("%s", "")<CR>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <C-s> :vert sb<CR>

" persistent undo
set undodir=~/.vim/undodir
set undofile

"command! -bang -nargs=* BTags
"  \  if &filetype == 'go'
"  \|   call fzf#vim#buffer_tags(<q-args>, 'gotags -silent -sort '.shellescape(expand('%')), <bang>0)
"  \| else
"  \|   call fzf#vim#buffer_tags(<q-args>, <bang>0)
"  \| endif

