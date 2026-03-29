---@type vim.lsp.Config
return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml' },
    root_markers = { '.git' },
    settings = {
        yaml = {
            keyOrdering = false,
            maxComputationLines = 5000,
            schemaStore = {
                enable = true,
                url = 'https://www.schemastore.org/json-schema-catalog.json',
            },
        },
    },
}
