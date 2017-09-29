" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'tomasr/molokai'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer ' }
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" Source vim configuration upon save
augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END

" Enable mouse
if has('mouse')
	set mouse=a
endif

" Molokai 256 color scheme 
colorscheme molokai
set t_Co=256
let g:rehash256 = 1

" When set to 'dark', Vim will try to use colors that look
" good on a dark background. When set to 'light', Vim will
" try to use colors that look good on a light background.
set background=dark

" Display the ruler at 81 characters
set colorcolumn=81

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
set clipboard=unnamed

" Set list chars (usage :set list/:set nolist)
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Quickfix list jumping
function! _lnext()
  try
    execute 'lnext'
  catch
    execute 'lfirst'
  endtry
endfunction

function! _lprevious()
  try
    execute 'lprevious'
  catch
    execute 'llast'
  endtry
endfunction

function! _cnext()
  try
    execute 'cnext'
  catch
    execute 'cfirst'
  endtry
endfunction

function! _cprevious()
  try
    execute 'cprevious'
  catch
    execute 'clast'
  endtry
endfunction

nnoremap <silent> <M-n> :call _lnext()<CR>
nnoremap <silent> <M-m> :call _lprevious()<CR>
nnoremap <silent> <C-n> :call _cnext()<CR>
nnoremap <silent> <C-m> :call _cprevious()<CR>
nnoremap <leader>a :cclose<CR>


"" vim-go: https://github.com/fatih/vim-go-tutorial

" Let all lists be 'quickfix'
let g:go_list_type = "quickfix"

" Use goimports instead of gofmt by default
let g:go_fmt_command = "goimports"

" Go highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

"YouCompleteMe
"let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
