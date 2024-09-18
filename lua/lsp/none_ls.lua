local M = { "nvimtools/none-ls.nvim" }

M.event = { "BufReadPre", "BufNewFile" }
M.config = function()
    local none_ls = require("null-ls")
    local formatting = none_ls.builtins.formatting
    none_ls.setup({
        sources = {
            formatting.stylua,
            formatting.prettierd,
        },
    })
end

return {
    "nvim-lua/plenary.nvim",
    M,
}
