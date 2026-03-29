-- Manage languages here instead of editing multiple plugin files.
--
-- How this works:
-- 1. Add a new entry to the table below.
-- 2. Set `treesitter` to the parser name if you want Treesitter support.
-- 3. Set `lsp` to the server name if you want LSP support.
-- 4. If you add an `lsp` entry, also create a matching file in `lua/sina96/lsp/`.
--
-- Example:
-- python = {
--     treesitter = "python",
--     lsp = "pyright",
-- }
--
-- Notes:
-- - Treesitter parser names and LSP server names are not always the same.
-- - If a language only needs one of them, you can omit the other field.

return {
    lua = {
        treesitter = "lua",
        lsp = "lua_ls",
    },
    javascript = {
        treesitter = "javascript",
        lsp = "ts_ls",
    },
    python = {
        treesitter = "python",
        lsp = "pyright",
    },
    rust = {
        treesitter = "rust",
    },
    go = {
        treesitter = "go",
        lsp = "gopls",
    },
    yaml = {
        lsp = "yamlls",
    },
    sql = {
        lsp = "sqls",
    },
}
