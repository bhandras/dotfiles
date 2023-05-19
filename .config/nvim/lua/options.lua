vim.opt.mouse = "a"                             -- allow mouse

vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- do not allow editing if a file is being edited by another program

vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard

vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.pumheight = 10                          -- pop up menu height

vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

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

vim.g.mapleader = ","                           -- remap <leader> to ','

-- display the ruler at 81 characters
vim.cmd [[set colorcolumn=81]]

vim.cmd "set whichwrap+=<,>,[,],h,l"

-- show hybrid relative line numbers
vim.cmd [[set nu rnu]]

-- show file name in title bar
vim.cmd [[set title]]

-- allow multiple paste
vim.cmd [[xnoremap p pgvy]]

-- show the line and column number of the cursor position
vim.cmd [[set ruler]]

vim.cmd [[filetype plugin indent on]]

vim.cmd [[set diffopt+=linematch:50]]

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Unset the 'last search ipattern' register by hitting 'return'.
keymap("n", "<CR>", ":noh<CR><CR>", opts)

-- Select buffer with <leader>1..9
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
keymap("n", "<leader>s", "<cmd>Telescope aerial<cr>", opts)
keymap("n", "<leader>df", ":DiffviewFileHistory<cr>", opts)
keymap("n", "<leader>dx", ":DiffviewClose<cr>", opts)
keymap("n", "<leader>dt", ":DiffviewToggleFiles<cr>", opts)
keymap("n", "<leader>n", "<cmd>lua require('config.utils').echo_current_function_name()<cr>", opts)

keymap("n", "<leader>dd", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.run_to_cursor()<cr>", opts)
keymap("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", opts)

-- Override yank and paste to use the system clipboard.
keymap("n", "y", '"+y', opts)
keymap("v", "y", '"+y', opts)
keymap("n", "yy", '"+yy', opts)

keymap("n", "p", '"+p', opts)
keymap("n", "P", '"+P', opts)

keymap("n", "d", '"+d', opts)
keymap("v", "d", '"+d', opts)

keymap("i", "C-c", "<ESC>", opts)

-- File-dependent test runs
vim.cmd([[autocmd FileType go nnoremap <buffer> <leader>dt :lua require('dap-go').debug_test()<cr>]])

-- Use Treesitter for folding.
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
keymap("n", "<space>", "za", opts)

-- Use special indenting rules for Go files.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.tabstop = 8
        vim.opt_local.shiftwidth = 8
    end
})

-- Use internal formatting for bindings like gq.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})

vim.cmd('colorscheme kanagawa')
