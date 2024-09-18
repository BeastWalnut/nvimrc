local M = { "lukas-reineke/indent-blankline.nvim" }

M.main = "ibl"
M.event = "BufReadPre"
M.opts = {
    indent = {
        char = "|",
        highlight = "NonText",
    },
    scope = { enabled = false },
}

return M
