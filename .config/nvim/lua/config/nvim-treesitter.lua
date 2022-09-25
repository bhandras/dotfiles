local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup {
        -- one of "all", "maintained", or a list of languages
        ensure_installed = {"go", "lua", "python"},

        -- install languages synchronously
        sync_install = false,

        -- list of parsers to ignore installing
        ignore_install = { "" },

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- disable for these languages
            disable = { "" },

            -- can interfere and it is less performant
            additional_vim_regex_highlighting = false,
        },

        -- auto indent
        indent = {
            enable = true,
            disable = {"yaml"},
        },
    }
end

return M
