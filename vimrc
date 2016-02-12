set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

"Vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' "let Vundle manage Vundle
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/python-mode'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'tomasr/molokai'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-airline/vim-airline'

call vundle#end()

filetype plugin indent on

syntax enable "enable syntax highlighting

set background=dark "dark
set t_Co=256

colorscheme molokai
let g:rehash256 = 1 "molokai 256 color scheme
hi VisualNOS ctermbg=240
hi Visual ctermbg=238


"vim-airline
set laststatus=2 "status line always visible

"pymode
let g:pymode_rope = 0 "switch off rope
let g:pymode_folding = 0 "don't auto fold code

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = 1
let g:pymode_syntax_space_errors = 1
let g:pymode_options_colorcolumn = 0

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

"unset the 'last search ipattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

if has('mouse')
	set mouse=v	"use mouse in visual mode
endif

"YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_enable_diagnostic_signs = 0
let g:clang_format#style_options = {
  \ "AccessModifierOffset" : -4,
  \ "AllowShortIfStatementsOnASingleLine" : "true",
  \ "AlwaysBreakTemplateDeclarations" : "true",
  \ "TabWidth" : 4,
  \ "UseTab" : "Always",
  \ "ColumnLimit" : 0,
  \ "Standard" : "C++11",
  \ "BreakBeforeBraces" : "Attach"}

map gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
