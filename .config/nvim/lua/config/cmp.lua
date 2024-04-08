local M = {}

function M.setup()
    local cmp = require "cmp"
    local compare = require "cmp.config.compare"

    cmp.setup {
        completion = {
            completeopt = "menu,menuone,noinsert",
            keyword_length = 1,
        },
        snippet = {
            -- REQUIRED - must specify a snippet engine.
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = { 'menu', 'abbr', 'kind' },
            -- format = function(entry, item)
            --    local menu_icon = {
            --        nvim_lsp = 'λ',
            --        buffer = 'Ω',
            --        path = '🖫',
            --    }
            --    item.menu = menu_icon[entry.source.name]
            --    return item
            -- end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            -- ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-c>'] = cmp.mapping.abort(),

            -- Accept currently selected item. Set `select` to `false` to only
            -- confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sorting = {
            priority_weight = 1,
            comparators = {
                -- require("copilot_cmp.comparators").prioritize,

                -- Below is the default comparitor list and order for nvim-cmp
                compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                compare.exact,
                compare.score,
                compare.recently_used,
                compare.locality,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        },
        sources = {
            { name = "copilot" },
            { name = "nvim_lsp", max_item_count = 15 },
            { name = "nvim_lsp_signature_help" },
            { name = "treesitter" },
            { name = "path" },
            -- { name = "luasnip" },
            -- { name = "buffer", max_item_count = 5 },
            -- { name = "rg", max_item_count = 8 },
            -- { name = "nvim_lua" },
        },
    }
end

return M
