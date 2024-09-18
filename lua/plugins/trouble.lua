local M = { "folke/trouble.nvim" }

M.keys = Gen_map({
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "[W]orkspace" },
    q = { "<cmd>TroubleToggle quickfix<CR>", "[Q]uickfix" },
}, {
    name = "Trouble",
    prefix = "<leader>t",
})
M.config = function(_, opts)
    require("trouble").setup(opts)
end

return {
    "nvim-tree/nvim-web-devicons",
    M,
}
