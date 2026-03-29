---@type vim.lsp.Config
return {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', 'tslint.json', '.git' },
    init_options = {
        hostInfo = 'neovim',
    },
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
        typescript = {
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferences = {
                importModuleSpecifierPreference = 'shortest',
                jsxAttributeDefaultValue = 'none',
                quotePreference = 'single',
                useAliasesForRenames = true,
            },
        },
        javascript = {
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferences = {
                importModuleSpecifierPreference = 'shortest',
                jsxAttributeDefaultValue = 'none',
                quotePreference = 'single',
                useAliasesForRenames = true,
            },
        },
    },
}
