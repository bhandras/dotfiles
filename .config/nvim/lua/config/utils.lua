local M = {}

function M.echo_current_function_name()
    vim.api.nvim_echo(
        { { require('nvim-treesitter').statusline(), 'None' } },
        false, {}
    )
end

return M
