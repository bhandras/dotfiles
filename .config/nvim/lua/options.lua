--[=====[ 
" set up folding
set foldmethod=indent
set nofoldenable
set foldlevel=99
nnoremap <space> za

]=====]--


vim.opt.mouse = "a"                             -- allow mouse

vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- do not allow editing if a file is being edited by another program

vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file

vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard

vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.pumheight = 10                          -- pop up menu height

vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files

vim.opt.hlsearch = true                         -- highlight all search pattern matches
vim.opt.incsearch = true
vim.opt.ignorecase = true                       -- case insensitive matching
vim.opt.smartcase = true                        -- do not ignore case if search string contains uppercase characters

vim.opt.showtabline = 2                         -- always show tabs

vim.opt.autoindent = true                       -- copy indent from current line when starting a new line
vim.opt.smartindent = true                      -- make indenting smart

vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window

vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)

vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 8 spaces for a tab

vim.opt.cursorline = true                       -- highlight the current line

vim.opt.number = true                           -- set numbered lines
vim.opt.numberwidth = 2                         -- set number column width to 2
vim.opt.relativenumber = false                  -- set relative numbered lines

vim.opt.signcolumn = "yes"                      -- always show the sign column

vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor

vim.opt.sidescrolloff = 8

vim.opt.shortmess:append "c"

-- remap <leader> to ','
vim.cmd [[let mapleader=',']]

-- display the ruler at 81 characters
vim.cmd [[set colorcolumn=81]]

vim.cmd "set whichwrap+=<,>,[,],h,l"

-- unset the 'last search ipattern' register by hitting 'return'
vim.cmd [[nnoremap <CR> :noh<CR><CR>]]

-- show hybrid relative line numbers
vim.cmd [[set nu rnu]]

-- show file name in title bar
vim.cmd [[set title]]

-- allow multiple paste
vim.cmd [[xnoremap p pgvy]]

-- show the line and column number of the cursor position
vim.cmd [[set ruler]]

vim.cmd [[filetype plugin indent on]]

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>d", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>x", ":TroubleToggle lsp_references<CR>", opts)

keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)

-- TODO: show current function name
-- vim.cmd [[nnoremap <leader>n :echo cfi#format("%s", "")<CR>]]