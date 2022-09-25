local M = {}

function M.setup()
    require("nvim-tree").setup {
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        renderer = {
            root_folder_modifier = ":t",
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "S",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
    }
end

return M
