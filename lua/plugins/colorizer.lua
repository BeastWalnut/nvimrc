local M = { "norcalli/nvim-colorizer.lua" }

M.ft = "json"
M.name = "colorizer"
M.cmd = "ColorizerAttachToBuffer"
M.opts = { mode = "foreground" }
M.config = function(_, opts)
    require("colorizer").setup({
        "markdown",
        "json",
    }, opts)
end

return M
