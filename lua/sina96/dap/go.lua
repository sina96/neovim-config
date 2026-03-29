local M = {}

function M.setup()
    -- Go debugging is provided by nvim-dap-go, which configures Delve for us.
    require("dap-go").setup()
end

return M
