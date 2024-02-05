return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {"<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc="[T]rouble [W]orksp diagnostic"},
        { "<leader>tq", "<cmd>TroubleToggle quickfix<CR>", desc = "[T]rouble [Q]uickfix" },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
}
