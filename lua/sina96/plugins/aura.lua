return
{
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
        local function set_neotree_popup_highlights()
            local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
            local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })

            local fg = normal.fg or normal.foreground or 0xe0e0e0
            local bg = normal_float.bg or normal_float.background or normal.bg or normal.background or 0x1a1a1a

            vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { fg = fg, bg = bg })
            vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = fg, bg = bg, bold = true })
            vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = fg, bg = bg })
            vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = bg, bg = fg, bold = true })
        end

        vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        vim.cmd([[colorscheme aura-dark]])

        set_neotree_popup_highlights()

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "aura-dark",
            callback = set_neotree_popup_highlights,
        })
    end
}
