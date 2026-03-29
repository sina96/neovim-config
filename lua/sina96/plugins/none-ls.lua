return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local formatter_config = require("sina96.formatters")
        local sources = {}

        -- Build the none-ls source list from `lua/sina96/formatters.lua`.
        -- This keeps formatter and linter management in one place.
        for _, language in pairs(formatter_config) do
            for _, formatter in ipairs(language.formatting or {}) do
                if type(formatter) == "string" then
                    table.insert(sources, null_ls.builtins.formatting[formatter])
                end
            end

            for _, diagnostic in ipairs(language.diagnostics or {}) do
                if type(diagnostic) == "string" then
                    table.insert(sources, null_ls.builtins.diagnostics[diagnostic])
                elseif diagnostic.extras then
                    local source = require("none-ls.diagnostics." .. diagnostic.name)

                    if diagnostic.command then
                        source = source.with({
                            command = diagnostic.command,
                        })
                    end

                    table.insert(sources, source)
                else
                    local source = null_ls.builtins.diagnostics[diagnostic.name]

                    if diagnostic.command then
                        source = source.with({
                            command = diagnostic.command,
                        })
                    end

                    table.insert(sources, source)
                end
            end
        end

        null_ls.setup({
            sources = sources,
        })
        vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = 'Format file' })
    end
}
