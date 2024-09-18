local M = { "folke/lazydev.nvim" }

M.ft = "lua"
M.dependencies = { "Bilal2453/luvit-meta" }
M.opts = {
    library = {
        { words = { "vim%.uv" }, path = "luvit-meta/library" },
    },
}

return M
