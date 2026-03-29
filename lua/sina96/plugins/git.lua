return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local function set_gitsigns_highlights()
                vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
                vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
                vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
                vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "Green" })
                vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "Blue" })
                vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "Red" })
                vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "DiffAdd" })
                vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "DiffChange" })
                vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "DiffDelete" })
                vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "PurpleFaded" })
            end

            require("gitsigns").setup({
                current_line_blame = true,
            })

            set_gitsigns_highlights()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "aura-dark",
                callback = set_gitsigns_highlights,
            })

            vim.keymap.set("n", "<leader>gn", require("gitsigns").next_hunk, { desc = "Git next hunk" })
            vim.keymap.set("n", "<leader>gp", require("gitsigns").prev_hunk, { desc = "Git previous hunk" })
            vim.keymap.set("n", "<leader>gh", require("gitsigns").preview_hunk, { desc = "Git preview hunk" })
            vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "Git reset hunk" })
            vim.keymap.set("n", "<leader>gb", require("gitsigns").blame_line, { desc = "Git blame line" })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local function set_lazygit_highlights()
                vim.api.nvim_set_hl(0, "LazyGitFloat", { fg = "#edecee", bg = "#15141b" })
                vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = "#a277ff", bg = "#15141b" })
            end

            vim.g.lazygit_floating_window_use_plenary = 1
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
            vim.g.lazygit_floating_window_winblend = 0

            set_lazygit_highlights()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "aura-dark",
                callback = set_lazygit_highlights,
            })

            vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Git lazygit" })
            vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", { desc = "Git lazygit current file" })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
            vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
            vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
        end,
    },
}
