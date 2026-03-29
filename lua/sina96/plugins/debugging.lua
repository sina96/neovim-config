return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mason-org/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            local debuggers = require("sina96.debuggers")
            local adapters = {}

            -- Debuggers are managed from `lua/sina96/debuggers.lua`.
            -- Keep language-specific DAP setup in `lua/sina96/dap/<language>.lua`.
            for _, debugger in pairs(debuggers) do
                if debugger.adapter then
                    table.insert(adapters, debugger.adapter)
                end
            end

            local function set_dapui_highlights()
                vim.api.nvim_set_hl(0, "DapUINormal", { fg = "#edecee", bg = "#15141b" })
                vim.api.nvim_set_hl(0, "DapUIFloatNormal", { fg = "#edecee", bg = "#15141b" })
                vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = "#a277ff", bg = "#15141b" })
                vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#a277ff", bold = true })
                vim.api.nvim_set_hl(0, "DapUIType", { fg = "#61ffca" })
                vim.api.nvim_set_hl(0, "DapUIValue", { fg = "#b3b9c5" })
                vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = "#f694ff", bold = true })
                vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = "#a277ff" })
                vim.api.nvim_set_hl(0, "DapUIThread", { fg = "#ffca85" })
                vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = "#61ffca", bold = true })
                vim.api.nvim_set_hl(0, "DapUIFrameName", { fg = "#edecee" })
                vim.api.nvim_set_hl(0, "DapUISource", { fg = "#61ffca" })
                vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = "#a277ff" })
                vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = "#61ffca" })
                vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = "#ff6767" })
                vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = "#a277ff" })
                vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = "#ffca85" })
                vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = "#61ffca", bold = true })
                vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = "#a277ff" })
                vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { fg = "#6d6d6d" })
                vim.api.nvim_set_hl(0, "DapUIStepOver", { fg = "#a277ff" })
                vim.api.nvim_set_hl(0, "DapUIStepInto", { fg = "#61ffca" })
                vim.api.nvim_set_hl(0, "DapUIStepOut", { fg = "#ffca85" })
                vim.api.nvim_set_hl(0, "DapUIStepBack", { fg = "#f694ff" })
                vim.api.nvim_set_hl(0, "DapUIPlayPause", { fg = "#61ffca" })
                vim.api.nvim_set_hl(0, "DapUIRestart", { fg = "#61ffca" })
                vim.api.nvim_set_hl(0, "DapUIStop", { fg = "#ff6767" })
                vim.api.nvim_set_hl(0, "DapUIUnavailable", { fg = "#6d6d6d" })
            end

            local function dap_healthcheck()
                local lines = {
                    "DAP healthcheck",
                    "",
                }

                local function add_ok(message)
                    table.insert(lines, "OK   " .. message)
                end

                local function add_err(message)
                    table.insert(lines, "ERR  " .. message)
                end

                if package.loaded["dap"] then
                    add_ok("nvim-dap loaded")
                else
                    add_err("nvim-dap not loaded")
                end

                if package.loaded["dapui"] then
                    add_ok("nvim-dap-ui loaded")
                else
                    add_err("nvim-dap-ui not loaded")
                end

                if package.loaded["mason-nvim-dap"] then
                    add_ok("mason-nvim-dap loaded")
                else
                    add_err("mason-nvim-dap not loaded")
                end

                for language, debugger in pairs(debuggers) do
                    local adapter = debugger.adapter or "unknown"
                    add_ok(language .. " adapter configured as " .. adapter)

                    if adapter == "delve" then
                        local dlv = vim.fn.exepath("dlv")
                        if dlv == "" then
                            add_err(language .. " debugger binary not found: dlv")
                        else
                            add_ok(language .. " debugger binary found: " .. dlv)
                        end
                    end

                    if debugger.setup then
                        local ok = pcall(require, "sina96.dap." .. debugger.setup)
                        if ok then
                            add_ok(language .. " setup module loaded")
                        else
                            add_err(language .. " setup module missing: sina96.dap." .. debugger.setup)
                        end
                    end
                end

                vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "DAP Healthcheck" })
            end

            dapui.setup({
                floating = {
                    border = "rounded",
                },
            })

            require("mason-nvim-dap").setup({
                ensure_installed = adapters,
                automatic_installation = true,
            })

            for _, debugger in pairs(debuggers) do
                if debugger.setup then
                    require("sina96.dap." .. debugger.setup).setup()
                end
            end

            set_dapui_highlights()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "aura-dark",
                callback = set_dapui_highlights,
            })

            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug continue' })
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug toggle breakpoint' })
            vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug step into' })
            vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug step over' })
            vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug step out' })
            vim.keymap.set('n', '<leader>dh', dap_healthcheck, { desc = 'Debug healthcheck' })
            vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug toggle UI' })
            vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug terminate' })
            vim.api.nvim_create_user_command("DapHealthcheck", dap_healthcheck, {})

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}
