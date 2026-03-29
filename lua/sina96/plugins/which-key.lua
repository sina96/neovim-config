return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.setup({})
        wk.add({
            { "<leader>c", group = "code" },
            { "<leader>d", group = "debug" },
            { "<leader>f", group = "file" },
            { "<leader>g", group = "git" },
            { "<leader>p", group = "project" },
        })
    end,
}
