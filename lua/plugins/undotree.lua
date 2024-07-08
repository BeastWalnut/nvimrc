return {
    "mbbill/undotree", -- Undo Tree.
    event = { "BufReadPre", "BufNewFile" },
    keys = Gen_map({
        u = { "<Cmd>UndotreeShow<CR><Cmd>UndotreeFocus<CR>", "Show" },
        q = { "<Cmd>UndotreeHide<CR>", "[Q]uit" },
    }, {
        name = "Undo",
        prefix = "<leader>u",
    }),
}
