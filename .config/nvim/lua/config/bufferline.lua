local M = {}

function M.setup()
    require("bufferline").setup {
        options = {
            numbers = function(opts)
                return string.format('%s:', opts.ordinal)
            end,
            modified_icon = "●",
            close_icon = "",
            buffer_close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",

            --        offsets = {
            --            { 
            --                filetype = "NvimTree",
            --                text = "", 
            --                padding = 1,
            --            },
            --        },

            show_buffer_icons = false,
            show_close_icon = false,
            show_buffer_close_icons = false,
            show_tab_indicators = true,

            persist_buffer_sort = false,
            separator_style = "thin",
            enforce_regular_tabs = false,
            always_show_bufferline = true,
        },
    }
end

return M
