return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function set_dashboard_highlights()
            vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#a277ff", bold = true })
            vim.api.nvim_set_hl(0, "DashboardProjectTitle", { fg = "#a277ff", bold = true })
            vim.api.nvim_set_hl(0, "DashboardProjectTitleIcon", { fg = "#a277ff" })
            vim.api.nvim_set_hl(0, "DashboardRecentProjectIcon", { fg = "#a277ff" })
            vim.api.nvim_set_hl(0, "DashboardProjectIcon", { fg = "#61ffca" })
            vim.api.nvim_set_hl(0, "DashboardMruTitle", { fg = "#ffca85", bold = true })
            vim.api.nvim_set_hl(0, "DashboardMruIcon", { fg = "#ffca85" })
            vim.api.nvim_set_hl(0, "DashboardFiles", { fg = "#b3b9c5" })
            vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#f694ff", bold = true })
            vim.api.nvim_set_hl(0, "DashboardShortCutIcon", { fg = "#f694ff" })
            vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#6d6d6d" })
        end

        require("dashboard").setup({
            theme = "hyper",
            config = {
                header = {
                    " ██████   █████                   █████   █████  ███                 ",
                    "░░██████ ░░███                   ░░███   ░░███  ░░░                  ",
                    " ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  ",
                    " ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ ",
                    " ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ ",
                    " ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ ",
                    " █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████",
                    "░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ",
                },
                week_header = {
                    enable = false,
                },
                shortcut = {},
                project = {
                    enable = true,
                    limit = 8,
                    icon = " ",
                    label = "Recent Projects",
                    action = "Telescope find_files cwd=",
                },
                mru = {
                    limit = 10,
                    icon = " ",
                    label = "Recent Files",
                    cwd_only = false,
                },
                footer = {},
            },
        })

        set_dashboard_highlights()

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "aura-dark",
            callback = set_dashboard_highlights,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "DashboardLoaded",
            callback = set_dashboard_highlights,
        })
    end,
}
