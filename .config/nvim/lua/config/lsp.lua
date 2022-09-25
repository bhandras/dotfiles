M = {}

local servers = {
    gopls = {
        settings = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = {
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
            },
        },
    },
    pyright = {
        analysis = {
            typeCheckingMode = "off",
        },
    },
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're
                    -- using (most likely LuaJIT in the case of Neovim).
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                        "vim", "describe", "it", "before_each", "after_each",
                        "packer_plugins",
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    },
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
                completion = { callSnippet = "Both" },
                telemetry = { enable = false },
                hint = {
                    enable = true,
                },
            },
        },
    },
    tsserver = {
        disable_formatting = true,
        settings = {},
    },
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
            },
        },
    },
    yamlls = {
        schemastore = {
            enable = true,
        },
        settings = {
            yaml = {
                hover = true,
                completion = true,
                validate = true,
                schemas = require("schemastore").json.schemas(),
            },
        },
    },
    dockerls = {},
    bashls = {},
    vimls = {},
    html = {},
    tailwindcss = {},
}

local function setup_lsp_keymaps(bufnr)
    local bufmap = function(mode, lhs, rhs)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    bufmap("n", "gx", "<cmd>lua vim.lsp.buf.references()<CR>")
    bufmap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    bufmap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>")
    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>")
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>")
end

local function setup_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(
            sign.name,
            {
                texthl = sign.name,
                text = sign.text,
                numhl = "",
            }
        )
    end

    local diag_config = {
        -- enable virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(diag_config)
end

M.on_attach = function(_, bufnr)
    -- Enable completion triggered by <C-X><C-O>
    -- See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Use LSP as the handler for formatexpr.
    -- See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    setup_lsp_keymaps(bufnr)
end


-- For nvim-cmp.
M.capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local server_opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

function M.setup()
    -- TODO: setup null-ls here
    -- require("config.null-ls").setup(opts)

    local lspconfig = require("lspconfig")

    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = false,
    }

    require("mason-lspconfig").setup_handlers {
        function(server_name)
            local opts = vim.tbl_deep_extend(
                "force", server_opts, servers[server_name] or {}
            )
            lspconfig[server_name].setup(opts)
        end,
    }

    setup_diagnostics()
end

-- Diagnostics.
local diagnostics_active = true

function M.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

-- Fix imports.
local function organize_imports(timeout_ms)
    local params = vim.lsp.util.make_range_params(nil, "utf-16")
    params.context = {
        only = { "source.organizeImports" },
    }

    local result = vim.lsp.buf_request_sync(
        0, "textDocument/codeAction", params, timeout_ms
    )

    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

-- Fix imports and format on save for Go files.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = function()
        organize_imports(3000)
        vim.lsp.buf.formatting_sync(nil, 3000)
    end,
})


return M
