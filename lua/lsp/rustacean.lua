local M = { "mrcjkb/rustaceanvim" }

M.ft = "rust"
M.version = "^4"
M.config = function()
    vim.g.rustaceanvim = {
        tools = { enable_clippy = true },
    }
end

return {
    "neovim/nvim-lspconfig",
    M,
}
