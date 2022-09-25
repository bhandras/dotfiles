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
        "morhetz/gruvbox",
        config = function()
            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_invert_selection = 0
            vim.cmd "colorscheme gruvbox"
        end,
        disable = false,
    }
    use {
        "NLKNguyen/papercolor-theme",
        config = function()
            vim.cmd "colorscheme PaperColor"
        end,
        disable = true,
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
        requires = {
            "nvim-treesitter/nvim-treesitter-context",
        },
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

    -- Fuzzy finder.
    use {
        'nvim-telescope/telescope.nvim',
        wants = {
            "plenary.nvim",
            "telescope-fzf-native.nvim",
        },
        requires = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make"
            },
        },
        tag = '0.1.0',
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("fzf")
        end,
    }

    -- File type specific settings and overrides.
    use {
        "nathom/filetype.nvim",
        config = function()
            require("filetype").setup({
                overrides = {
                    function_extensions = {
                        ["go"] = function()
                            vim.bo.filetype = "go"
                            -- override formatting for Go files.
                            vim.opt.tabstop = 8
                            vim.opt.shiftwidth = 8
                        end,
                    },
                },
            })
        end,
    }

    -- Automatically set up configuration after cloning packer.nvim.
    -- Must be at the end after all plugins.
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
