-- Manage none-ls sources here instead of hardcoding them in the plugin config.
--
-- How this works:
-- 1. Add one entry per language.
-- 2. Put formatters under `formatting`.
-- 3. Put linters under `diagnostics`.
-- 4. If a source comes from `none-ls-extras.nvim` or needs custom options,
--    use a table with extra metadata instead of a plain string.
--
-- Example:
-- javascript = {
--     formatting = { "prettier" },
--     diagnostics = {
--         { name = "eslint", extras = true, command = "eslint_d" },
--     },
-- }
--
-- Notes:
-- - none-ls builtin names and Mason package names are not always the same.
-- - `formatting` and `diagnostics` are different namespaces. Keep them separate.
-- - If a source stops existing or moves, you only need to update this file.

return {
    lua = {
        formatting = { "stylua" },
    },
    javascript = {
        formatting = { "prettier" },
        diagnostics = {
            { name = "eslint", extras = true, command = "eslint_d" },
        },
    },
    python = {
        formatting = { "black", "isort" },
    },
    go = {
        formatting = { "gofumpt" },
        diagnostics = { "golangci_lint" },
    },
}
