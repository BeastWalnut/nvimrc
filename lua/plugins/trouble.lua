local trouble = {
    "folke/trouble.nvim",
    keys = Gen_map({
        w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "[W]orkspace" },
        q = { "<cmd>TroubleToggle quickfix<CR>", "[Q]uickfix" },
    }, {
        name = "Trouble",
        prefix = "<leader>t",
    }),
    opts = {},
}

return {
    "nvim-tree/nvim-web-devicons",
    trouble,
}
