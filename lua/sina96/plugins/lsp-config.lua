return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- LSP servers are managed from `lua/sina96/languages.lua`.
            -- Each `lsp` entry must have a matching config file in `lua/sina96/lsp/`.
            local languages = require('sina96.languages')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local servers = {}

            for _, language in pairs(languages) do
                if language.lsp then
                    local server_config = require('sina96.lsp.' .. language.lsp)
                    server_config.capabilities = vim.tbl_deep_extend(
                        'force',
                        {},
                        capabilities,
                        server_config.capabilities or {}
                    )

                    vim.lsp.config(language.lsp, server_config)
                    table.insert(servers, language.lsp)
                end
            end

            vim.lsp.enable(servers)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP go to definition' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP code action' })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            {
                "mason-org/mason.nvim", opts = {},
            },
            "neovim/nvim-lspconfig",
        },
        config = function()
            local languages = require('sina96.languages')
            local servers = {}

            for _, language in pairs(languages) do
                if language.lsp then
                    table.insert(servers, language.lsp)
                end
            end

            require("mason-lspconfig").setup {
                ensure_installed = servers,
            }
        end,
    }
}
