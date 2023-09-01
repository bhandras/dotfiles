local fn = vim.fn

-- Automatically install packer.
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file.
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


-- Use a protected call so we don't error out on first use.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install your plugins here
return packer.startup(function(use)
    -- Have packer manage itself.
    use "wbthomason/packer.nvim"

    -- Color schemes.
    use {
        "ellisonleao/gruvbox.nvim",
        config = function()
            -- local colors = require("gruvbox.palette").colors

            require("gruvbox").setup({
                undercurl = true,
                underline = true,
                bold = true,
                -- italic = true,
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "soft", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {
                    -- TODO: tune these to make diff view more readable.
                    --
                    --DiffDelete = { bg = colors.neutral_red, fg = colors.dark0 },
                    --DiffAdd = { bg = colors.none, fg = colors.none },
                    --DiffChange = { bg = colors.neutral_aqua, fg = colors.dark0 },
                    --DiffText = { bg = colors.neutral_yellow, fg = colors.dark0 },
                },
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
        disable = false,
    }

    use {
        "rebelot/kanagawa.nvim",
        config = function()
            require('kanagawa').setup({
                compile = false,             -- enable compiling the colorscheme
                undercurl = true,            -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                colors = {                   -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "wave",              -- Load "wave" theme when 'background' option is not set
                background = {               -- map the value of 'background' option to a theme
                    dark = "wave",           -- try "dragon" !
                    light = "lotus"
                },
            })
        end,
        disable = false,
    }


    -- Icons.
    use "kyazdani42/nvim-web-devicons"

    -- Status line.
    use {
        "nvim-lualine/lualine.nvim",
        wants = {
            "nvim-web-devicons",
        },
        event = "BufReadPre",
        after = "nvim-treesitter",
        config = function()
            require("config.lualine").setup()
        end,
    }

    -- Buffer line.
    use {
        "akinsho/nvim-bufferline.lua",
        wants = {
            "nvim-web-devicons",
        },
        event = "BufReadPre",
        config = function()
            require("config.bufferline").setup()
        end,
    }

    -- Tree.
    use {
        "kyazdani42/nvim-tree.lua",
        wants = {
            "nvim-web-devicons",
        },
        tag = "nightly",
        config = function()
            require("config.nvim-tree").setup()
        end,
    }

    -- Syntax highlight.
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function()
            require("config.nvim-treesitter").setup()
        end,
    }

    -- Completion.
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
        },
        opt = true,
        event = "InsertEnter",
        config = function()
            require("config.cmp").setup()
        end,
    }

    -- LSP.
    use {
        "neovim/nvim-lspconfig",
        wants = {
            "mason.nvim",
            "mason-lspconfig.nvim",
            "cmp-nvim-lsp",
            "schemastore.nvim",
        },
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "b0o/schemastore.nvim",
        },
        opt = true,
        event = { "BufReadPre" },
        config = function()
            require("config.lsp").setup()
        end,
    }

    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end,
    }

    use {
        "ruifm/gitlinker.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("gitlinker").setup()
        end,
    }

    use {
       "github/copilot.vim",
    }

    use {
        "SmiteshP/nvim-navic",
        wants = {
            "nvim-web-devicons",
        },
        requires = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("config.nvim-navic").setup()
        end,
    }

    -- Extra colors for LSP.
    use {
        "folke/lsp-colors.nvim",
        opt = true,
        event = { "BufReadPre" },
        config = function()
            require("lsp-colors").setup({
                Error = "#114b4b",
                Warning = "#e0af68",
                Information = "#0db9d7",
                Hint = "#10B981"
            })
        end,
    }

    -- Diagnostics and references UI.
    use {
        "folke/trouble.nvim",
        wants = "nvim-web-devicons",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            require("trouble").setup {
                use_diagnostic_signs = true,
            }
        end,
    }

    use {
        'stevearc/aerial.nvim',
        config = function()
            require('aerial').setup()
        end
    }

    -- Fuzzy finder.
    use {
        'nvim-telescope/telescope.nvim',
        wants = {
            "plenary.nvim",
            "telescope-fzf-native.nvim",
        },
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make"
            },
        },
        tag = '0.1.1',
        config = function()
            local telescope = require("telescope")
            telescope.setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    }
                }
            }

            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("aerial")
        end,
    }

    -- Debugging.
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap",
            "leoluz/nvim-dap-go",
        },
        config = function()
            require("config.nvim-dap").setup()
        end,
    }

    -- Diff and merge.
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('diffview').setup()
        end
    }

    use {
        "klen/nvim-test",
        config = function()
            require('nvim-test').setup({})
        end
    }

    -- Notes.
    use {
        "nvim-neorg/neorg",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                scratch = "~/neorg/scratch",
                                notes = "~/neorg/notes",
                            },
                            default_workspace = "scratch",
                        },
                    },
                },
            }
        end,
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    }

    -- Automatically set up configuration after cloning packer.nvim.
    -- Must be at the end after all plugins.
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
