set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

"Vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' "let Vundle manage Vundle
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomasr/molokai'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/indentpython.vim'

call vundle#end()

filetype plugin indent on

syntax enable "enable syntax highlighting

set splitbelow
set splitright

" delete current selection into 'blackhole' register and paste
vmap r "_dP

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

set background=dark "dark
set t_Co=256

colorscheme molokai
let g:rehash256 = 1 "molokai 256 color scheme
hi VisualNOS ctermbg=240
hi Visual ctermbg=238
nnoremap <C-Left> <PageUp>
nnoremap <C-Right> <PageDown>

"vim-airline
let g:airline_powerline_fonts=1
set laststatus=2 "status line always visible
let python_highlight_all=1

syntax on proper PEP8 Python indentation settings
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

"vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''
set wildignore+=*/tmp/*,*.so,*.swp,*.zip "MacOSX/Linux
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

set shiftwidth=2 "spaces for autoindents
set tabstop=2	"number of spaces a tab counts for
set expandtab "turn tabs to spaces
set autoindent
set smartindent

set number "show line numbers
set title "show file name in title bar

set hlsearch "highlight all search pattern matches
set ignorecase "case insensitive matching
set smartcase "do not ignore case if search string contains uppercase characters
set incsearch "match as you type
set clipboard=unnamed

"unset the 'last search ipattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

if has('mouse')
	set mouse=a
endif

"YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_python_binary_path = 'python3'
let g:clang_format#style_options = {
  \ "AccessModifierOffset" : -4,
  \ "AllowShortIfStatementsOnASingleLine" : "true",
  \ "AlwaysBreakTemplateDeclarations" : "true",
  \ "TabWidth" : 4,
  \ "UseTab" : "Always",
  \ "ColumnLimit" : 0,
  \ "Standard" : "C++11",
  \ "BreakBeforeBraces" : "Attach"}

map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

function! NextErr()
  try
    execute 'lnext'
  catch
    execute 'lfirst'
  endtry
endfunction

nnoremap <silent> <F8> :call NextErr()<CR>

autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr><C-o>
