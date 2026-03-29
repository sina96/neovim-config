-- Manage debuggers here instead of editing the DAP plugin setup directly.
--
-- How this works:
-- 1. Add one entry per language you want to debug.
-- 2. `adapter` is the Mason DAP package / adapter name.
-- 3. `setup` is an optional module in `lua/sina96/dap/` for language-specific DAP config.
-- 4. `debugging.lua` reads this file, asks Mason to install the adapters,
--    then loads each setup module automatically.
--
-- Example:
-- python = {
--     adapter = "python",
--     setup = "python",
-- }
--
-- Notes:
-- - Not every language needs a custom setup module.
-- - Keep shared UI, mappings, and DAP behavior in `plugins/debugging.lua`.
-- - Keep language-specific debugger setup in `dap/<language>.lua`.

return {
    go = {
        adapter = "delve",
        setup = "go",
    },
}
