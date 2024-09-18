local M = { "szw/vim-maximizer" }

M.cmd = { "MaximizerToggle" }
M.keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "[S]plit [M]aximize" },
}

return M
