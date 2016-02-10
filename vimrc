set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'

call vundle#end()

filetype plugin indent on

syntax enable
set background=dark
set t_Co=256

let g:pymode_rope = 0     " switch off rope
let g:pymode_folding = 0  " don't auto fold code

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = 1
let g:pymode_syntax_space_errors = 1
let g:pymode_options_colorcolumn = 0

set shiftwidth=2	" spaces for autoindents
set tabstop=2		" number of spaces a tab counts for
set expandtab		" turn tabs to spaces
set autoindent
set smartindent
set number		" show line numbers
set title		" show file name in title bar

set ignorecase		" case insensitive matching

if has('mouse')
	set mouse=v	" use mouse in visual mode
endif

