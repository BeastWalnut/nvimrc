local rustaceanvim = {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    config = function()
        vim.g.rustaceanvim = { tools = { enable_clippy = true } }
    end,
}

return {
    "neovim/nvim-lspconfig",
    rustaceanvim,
}
