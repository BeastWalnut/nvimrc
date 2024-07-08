local none_ls = {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local none_ls = require("null-ls")
        local formatting = none_ls.builtins.formatting
        none_ls.setup({
            sources = {
                formatting.stylua,
                formatting.prettierd,
            },
        })
    end,
}

return {
    "nvim-lua/plenary.nvim",
    none_ls,
}
