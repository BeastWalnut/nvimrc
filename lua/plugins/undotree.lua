local M = { "mbbill/undotree" } -- Undo Tree.

M.event = { "BufReadPre", "BufNewFile" }
M.keys = Gen_map({
    u = { "<Cmd>UndotreeShow<CR><Cmd>UndotreeFocus<CR>", "Show" },
    q = { "<Cmd>UndotreeHide<CR>", "[Q]uit" },
}, {
    name = "Undo",
    prefix = "<leader>u",
})

return M
