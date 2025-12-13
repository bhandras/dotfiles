vim.loader.enable()

-- Leader keys must be set before plugins load.
vim.g.mapleader = ','
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Silence noisy startup deprecation warnings from third-party plugins.
do
  local deprecate = vim.deprecate
  vim.deprecate = function(name, alternative, version, plugin, backtrace)
    if
      name == 'vim.tbl_add_reverse_lookup'
      or (type(name) == 'string' and name:match('vim%.tbl_add_reverse_lookup'))
      or name == 'vim.tbl_flatten'
      or (type(name) == 'string' and name:match('vim%.tbl_flatten'))
      or name == 'vim.lsp.start_client()'
      or name == 'vim.lsp.start_client'
      or (type(name) == 'string' and name:match('vim%.lsp%.start_client'))
    then
      return
    end
    return deprecate(name, alternative, version, plugin, backtrace)
  end
end

-- Core UI/UX tweaks carried over from the old config.
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.colorcolumn = '81'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.winborder = 'rounded'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Global keymaps (plugin-specific mappings live near plugin setup).
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('i', '<Esc>', '<C-c>', { desc = 'Leave insert (Esc as Ctrl-C)' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper window' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Diagnostic float' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix' })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.conf',
  command = 'set filetype=dosini',
})

-- Plugins via the new vim.pack.
local plugins = {
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/tpope/vim-sleuth' },
  { src = 'https://github.com/numToStr/Comment.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/folke/todo-comments.nvim' },
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
  { src = 'https://github.com/akinsho/bufferline.nvim' },
  { src = 'https://github.com/folke/trouble.nvim' },
  { src = 'https://github.com/sindrets/diffview.nvim' },
  { src = 'https://github.com/klen/nvim-test' },
  { src = 'https://github.com/github/copilot.vim' },
  { src = 'https://github.com/vhyrro/luarocks.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-neorg/neorg' },
  { src = 'https://github.com/nvim-neotest/neotest' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' },
  { src = 'https://github.com/antoinemadec/FixCursorHold.nvim' },
  { src = 'https://github.com/fredrikaverpil/neotest-golang' },
  { src = 'https://github.com/ruifm/gitlinker.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/leoluz/nvim-dap-go' },
  { src = 'https://github.com/rcarriga/nvim-dap-ui' },
  { src = 'https://github.com/theHamsta/nvim-dap-virtual-text' },
  { src = 'https://github.com/ldelossa/gh.nvim' },
  { src = 'https://github.com/ldelossa/litee.nvim' },
  { src = 'https://github.com/f-person/git-blame.nvim' },
  { src = 'https://github.com/julienvincent/hunk.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') },
}
if vim.fn.executable('make') == 1 then
  table.insert(plugins, { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' })
end
vim.pack.add(plugins)

for _, plugin in ipairs({
  'tokyonight.nvim',
  'vim-sleuth',
  'Comment.nvim',
  'gitsigns.nvim',
  'which-key.nvim',
  'telescope.nvim',
  'plenary.nvim',
  'telescope-ui-select.nvim',
  'telescope-fzf-native.nvim',
  'nvim-web-devicons',
  'todo-comments.nvim',
  'mini.nvim',
  'nvim-treesitter',
  'nvim-tree.lua',
  'bufferline.nvim',
  'trouble.nvim',
  'diffview.nvim',
  'nvim-test',
  'copilot.vim',
  'luarocks.nvim',
  'nui.nvim',
  'neorg',
  'neotest',
  'nvim-nio',
  'FixCursorHold.nvim',
  'neotest-golang',
  'gitlinker.nvim',
  'nvim-dap',
  'nvim-dap-go',
  'nvim-dap-ui',
  'nvim-dap-virtual-text',
  'gh.nvim',
  'litee.nvim',
  'git-blame.nvim',
  'hunk.nvim',
  'mason.nvim',
  'mason-lspconfig.nvim',
  'mason-tool-installer.nvim',
  'blink.cmp',
}) do
  pcall(vim.cmd.packadd, plugin)
end

require('tokyonight').setup({})
vim.cmd.colorscheme('tokyonight-night')
vim.cmd.hi('Comment gui=none')

require('Comment').setup()
require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})
require('which-key').setup()

local function lsp_symbol_kind_prefix(symbol_kind)
  local kind = symbol_kind or ''

  if vim.g.have_nerd_font then
    -- Match the `blink.cmp` icon set for consistent UI.
    local icons = {
      Text = '󰉿',
      Method = '󰊕',
      Function = '󰊕',
      Constructor = '󰒓',

      Field = '󰜢',
      Variable = '󰆦',
      Property = '󰖷',

      Class = '󱡠',
      Interface = '󱡠',
      Struct = '󱡠',
      Module = '󰅩',

      Unit = '󰪚',
      Value = '󰦨',
      Enum = '󰦨',
      EnumMember = '󰦨',

      Keyword = '󰻾',
      Constant = '󰏿',

      Snippet = '󱄽',
      Color = '󰏘',
      File = '󰈔',
      Reference = '󰬲',
      Folder = '󰉋',
      Event = '󱐋',
      Operator = '󰪚',
      TypeParameter = '󰬛',
    }

    -- LSP/telescope kinds typically come in TitleCase (e.g. "Method", "Struct").
    -- Some servers may send lowercase; normalize by trying a few forms.
    local title_kind = kind:gsub('^%l', string.upper)
    return icons[kind] or icons[title_kind] or icons[kind:lower():gsub('^%l', string.upper)] or '󰉿'
  end

  local lower_kind = kind:lower()
  local letters = {
    class = 'c',
    constant = 'k',
    constructor = 'n',
    enum = 'e',
    enummember = 'e',
    event = 'e',
    field = 'f',
    file = 'f',
    ['function'] = 'f',
    interface = 'i',
    key = 'k',
    method = 'm',
    module = 'm',
    namespace = 'n',
    number = '#',
    object = 'o',
    operator = 'o',
    package = 'p',
    property = 'p',
    string = 's',
    struct = 's',
    typeparameter = 't',
    variable = 'v',
  }

  return letters[lower_kind] or '?'
end

local function gen_lsp_symbols_entry_with_prefix(opts)
  opts = opts or {}

  local entry_display = require('telescope.pickers.entry_display')
  local make_entry = require('telescope.make_entry')
  local utils = require('telescope.utils')

  local hidden = opts.hide_path or utils.is_path_hidden(opts)

  local display_items = {
    { width = 1 },
    { remaining = true },
  }
  if not hidden then
    table.insert(display_items, 1, { width = vim.F.if_nil(opts.fname_width, 30) })
  end

  local displayer = entry_display.create({
    separator = ' ',
    hl_chars = { ['['] = 'TelescopeBorder', [']'] = 'TelescopeBorder' },
    items = display_items,
  })

  local make_display = function(entry)
    local icon = lsp_symbol_kind_prefix(entry.symbol_type)
    if opts.continuous then
      if hidden then
        return string.format('%s %s', icon, entry.symbol_name)
      end
      local display_path = utils.transform_path(opts, entry.filename)
      return string.format('%s  %s %s', display_path, icon, entry.symbol_name)
    end

    if hidden then
      return displayer({
        { icon, 'TelescopeResultsComment' },
        entry.symbol_name,
      })
    end

    local display_path, path_style = utils.transform_path(opts, entry.filename)
    local path_hl = path_style
    if type(path_style) == 'table' then
      path_hl = function()
        return path_style
      end
    end
    return displayer({
      {
        display_path,
        path_hl,
      },
      { icon, 'TelescopeResultsComment' },
      entry.symbol_name,
    })
  end

  return function(entry)
    local filename = vim.F.if_nil(entry.filename, entry.bufnr and vim.api.nvim_buf_get_name(entry.bufnr) or nil)
    local symbol_msg = entry.text or ''
    local symbol_type, symbol_name = symbol_msg:match('%[(.+)%]%s+(.*)')
    symbol_type = symbol_type or 'Unknown'
    symbol_name = symbol_name or symbol_msg
    if opts.strip_container then
      symbol_name = vim.trim(symbol_name:gsub('%s+in%s+.+$', ''))
    end

    local ordinal = symbol_name .. ' ' .. symbol_type
    if not hidden and filename then
      ordinal = filename .. ' ' .. ordinal
    end

    return make_entry.set_default_entry_mt({
      value = entry,
      ordinal = ordinal,
      display = make_display,

      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      symbol_name = symbol_name,
      symbol_type = symbol_type,
      start = entry.start,
      finish = entry.finish,
    }, opts)
  end
end

local function gen_vimgrep_entry_continuous(opts)
  opts = opts or {}
  local make_entry = require('telescope.make_entry')
  local utils = require('telescope.utils')

  local original = make_entry.gen_from_vimgrep(opts)
  return function(entry)
    local item = original(entry)
    local filename = item.filename or item.path or ''
    local display_path = utils.transform_path(opts, filename)
    local lnum = item.lnum or 0
    local col = item.col or 0
    local text = item.text or ''
    item.display = string.format('%s:%d:%d  %s', display_path, lnum, col, text)
    return item
  end
end

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'bottom',
      preview_height = 0.6,
      width = 0.95,
      height = 0.9,
    },
  },
  pickers = {
    lsp_document_symbols = {
      entry_maker = gen_lsp_symbols_entry_with_prefix({ hide_path = true }),
    },
    lsp_dynamic_workspace_symbols = {
      entry_maker = gen_lsp_symbols_entry_with_prefix({ strip_container = true, continuous = true }),
      layout_strategy = 'vertical',
      layout_config = {
        prompt_position = 'bottom',
        preview_height = 0.55,
        width = 0.95,
        height = 0.9,
      },
    },
    live_grep = {
      entry_maker = gen_vimgrep_entry_continuous({}),
      layout_strategy = 'vertical',
      layout_config = {
        prompt_position = 'bottom',
        preview_height = 0.6,
        width = 0.95,
        height = 0.9,
      },
    },
  },
  extensions = { ['ui-select'] = require('telescope.themes').get_dropdown({ prompt_position = 'bottom' }) },
})
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader><leader>', telescope_builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>/', function()
  telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
    prompt_position = 'bottom',
  }))
end, { desc = 'Fuzzy search buffer' })

require('todo-comments').setup({ signs = false })

require('mini.ai').setup({ n_lines = 500 })
require('mini.surround').setup()
local mini_statusline = require('mini.statusline')
mini_statusline.setup({ use_icons = vim.g.have_nerd_font })
mini_statusline.section_location = function()
  return '%2l:%-2v'
end

local in_git_session = vim.env.GIT_DIR ~= nil or vim.env.GIT_INDEX_FILE ~= nil
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'gitcommit',
    'git_rebase',
    'go',
    'python',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'vim',
    'vimdoc',
  },
  auto_install = not in_git_session,
  highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
  indent = { enable = true, disable = { 'ruby' } },
})
require('nvim-treesitter.install').prefer_git = not in_git_session

require('nvim-tree').setup({
  update_focused_file = { enable = true, update_cwd = true },
  renderer = {
    root_folder_modifier = ':t',
    icons = {
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          arrow_open = '',
          arrow_closed = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '',
          staged = 'S',
          unmerged = '',
          renamed = '➜',
          untracked = 'U',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
})
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })

require('bufferline').setup({
  options = {
    numbers = function(opts)
      return string.format('%s:', opts.ordinal)
    end,
    modified_icon = '●',
    close_icon = '',
    buffer_close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    show_buffer_icons = true,
    show_close_icon = false,
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    persist_buffer_sort = false,
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
})
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, ':BufferLineGoToBuffer ' .. i .. '<CR>', { desc = 'Switch to buffer ' .. i })
end

require('trouble').setup({ use_diagnostic_signs = true })
vim.keymap.set('n', '<leader>dd', ':TroubleToggle document_diagnostics focus=true<CR>', { desc = '[T]oggle Diagnostics' })
vim.keymap.set('n', '<leader>x', ':TroubleToggle lsp_references focus=true<CR>', { desc = 'Toggle [R]eferences' })

require('diffview').setup()
require('nvim-test').setup({})

vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)', { desc = 'Next Copilot Suggestion' })
vim.keymap.set('i', '<C-[>', '<Plug>(copilot-prev)', { desc = 'Previous Copilot Suggestion' })

local ok_luarocks, luarocks = pcall(require, 'luarocks-nvim')
if ok_luarocks then
  luarocks.setup({})
end

local ok_neorg, neorg = pcall(require, 'neorg')
if ok_neorg then
  neorg.setup({
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            scratch = '~/neorg/scratch',
            notes = '~/neorg/notes',
          },
          default_workspace = 'scratch',
        },
      },
    },
  })
end

require('neotest').setup({
  adapters = {
    require('neotest-golang'),
  },
})
vim.keymap.set('n', '<leader>nt', ':Neotest summary toggle<CR>', { desc = '[N]eotest [T]oggle Summary' })
vim.keymap.set('n', '<leader>no', ':Neotest output-panel toggle<CR>', { desc = '[N]eotest Toggle [O]utput Panel' })
vim.keymap.set('n', '<leader>nd', function()
  require('neotest').run.run({ strategy = 'dap' })
end, { desc = '[N]eotest [D]ebug nearest test' })

local git = require('gitlinker.git')
local original_get_branch_remote = git.get_branch_remote
git.get_branch_remote = function()
  local git_root = git.get_git_root()
  if git_root then
    local branches = vim.fn.systemlist({ 'git', '-C', git_root, 'branch', '--remotes', '--contains', 'HEAD' })
    for _, remote in ipairs({ 'upstream', 'origin' }) do
      for _, br in ipairs(branches) do
        if br:match('^%s*' .. remote .. '/') then
          return remote
        end
      end
    end
  end
  return original_get_branch_remote()
end

require('gitlinker').setup({
  mappings = nil,
  callbacks = {
    ['github.com'] = require('gitlinker.hosts').get_github_type_url,
  },
})
vim.keymap.set('n', '<leader>gy', function()
  require('gitlinker').get_buf_range_url('n')
end, { silent = true, desc = 'Copy git link (prefers upstream)' })
vim.keymap.set('v', '<leader>gy', function()
  require('gitlinker').get_buf_range_url('v')
end, { silent = true, desc = 'Copy git link (prefers upstream)' })

local dap = require('dap')
require('dap-go').setup()
require('dapui').setup()
require('nvim-dap-virtual-text').setup({ enabled = true, commented = false })
dap.listeners.after.event_initialized['dapui_config'] = function()
  require('dapui').open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  require('dapui').close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  require('dapui').close()
end
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug Step [I]nto' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug Step [O]ver' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[D]ebug Step [O]ut' })
vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = '[D]ebug [R]EPL' })
vim.keymap.set('n', '<leader>du', function()
  require('dapui').toggle()
end, { desc = '[D]ebug [U]I Toggle' })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '[D]ebug [L]ast' })

require('litee.lib').setup()
require('litee.gh').setup()

local ok_gitblame, gitblame = pcall(require, 'gitblame')
if ok_gitblame then
  gitblame.setup({
    enabled = false,
    message_template = ' <summary> • <date> • <author> • <<sha>>',
    date_format = '%m-%d-%Y %H:%M:%S',
    virtual_text_column = 1,
  })
  vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { desc = 'Toggle Git Blame' })
end

require('hunk').setup({})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.formatoptions = 'tcrqnj'
    vim.opt_local.textwidth = 80
    vim.opt_local.formatexpr = ''
    vim.opt_local.formatprg = ''
    vim.opt_local.comments = 's1:/*,mb:*,ex:*/,://'
    if vim.fn.maparg('gq', 'x') ~= '' then
      pcall(vim.api.nvim_buf_del_keymap, 0, 'x', 'gq')
    end
  end,
})

local notify_original = vim.notify
vim.notify = function(msg, ...)
  if
    msg
    and (
      msg:match('position_encoding param is required')
      or msg:match('Defaulting to position encoding of the first client')
      or msg:match('multiple different client offset_encodings')
      or msg:match('vim%.tbl_add_reverse_lookup is deprecated')
    )
  then
    return
  end
  return notify_original(msg, ...)
end

require('mason').setup()

local servers = {
  gopls = {
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git'),
    single_file_support = true,
    settings = {
      gopls = {
        codelenses = { tidy = true },
        analyses = { unusedparams = true, fillstruct = true, nilness = true, shadow = true },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        completeUnimported = true,
        usePlaceholders = true,
      },
    },
  },
  pyright = {},
  rust_analyzer = {},
  jsonls = {},
  yamlls = {},
  clangd = { cmd = { 'clangd', '--offset-encoding=utf-16' } },
  dockerls = {},
  bashls = {},
  vimls = {},
  html = {},
  tailwindcss = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim', 'require' } },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        completion = { callSnippet = 'Replace' },
        telemetry = { enable = false },
      },
    },
  },
}

require('mason-lspconfig').setup({
  ensure_installed = vim.tbl_keys(servers),
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    'dockerls',
    'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'pyright',
    'rust_analyzer',
    'stylua',
    'tailwindcss',
    'vimls',
    'yamlls',
  },
})

local lspconfig = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { source = 'if_many' },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP keymaps',
  callback = function(event)
    -- Helper to define buffer-local LSP mappings with consistent descriptions.
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    map('<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, '[F]ormat')

    -- Format on save for Go buffers (gofmt via gopls).
    if vim.bo[event.buf].filetype == 'go' then
      local client_id = event.data and event.data.client_id or nil
      local client = client_id and vim.lsp.get_client_by_id(client_id) or nil
      if client and client.server_capabilities and client.server_capabilities.documentFormattingProvider then
        local format_augroup = vim.api.nvim_create_augroup('lsp-format-on-save', { clear = false })
        vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = event.buf })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = format_augroup,
          buffer = event.buf,
          callback = function()
            vim.lsp.buf.format({
              bufnr = event.buf,
              timeout_ms = 2000,
              filter = function(format_client)
                return format_client.name == 'gopls'
              end,
            })
          end,
          desc = 'LSP: gofmt on save (gopls)',
        })
      end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client_id = event.data and event.data.client_id or nil
    local client = client_id and vim.lsp.get_client_by_id(client_id) or nil
    if client and client.server_capabilities and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-document-highlight', { clear = false })
      vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = highlight_augroup,
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = highlight_augroup,
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

for server, config in pairs(servers) do
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end

require('blink.cmp').setup({
  signature = { enabled = true },
  keymap = {
    preset = 'default',
    ['<C-space>'] = {},
    ['<C-p>'] = {},
    ['<Tab>'] = {},
    ['<S-Tab>'] = {},
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-y>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-n>'] = { 'select_and_accept' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-l>'] = { 'snippet_forward', 'fallback' },
    ['<C-h>'] = { 'snippet_backward', 'fallback' },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'normal',
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { 'lsp' },
        columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } },
      },
    },
  },
  cmdline = {
    keymap = {
      preset = 'inherit',
      ['<CR>'] = { 'accept_and_enter', 'fallback' },
    },
  },
  sources = { default = { 'lsp' } },
})
