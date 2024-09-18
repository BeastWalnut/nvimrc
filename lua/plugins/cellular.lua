local M = { "eandrju/cellular-automaton.nvim" }

M.name = "automaton"
M.keys = Gen_map({
    r = { "<cmd>CellularAutomaton make_it_rain<CR>", "[R]ain" },
    l = { "<cmd>CellularAutomaton game_of_life<CR>", "[L]ife" },
}, {
    name = "Automaton",
    prefix = "<leader>a",
})

return M
