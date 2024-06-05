return {
	"eandrju/cellular-automaton.nvim",
	name = "automaton",
	keys = Gen_map({
		r = { "<cmd>CellularAutomaton make_it_rain<CR>", "[R]ain" },
		l = { "<cmd>CellularAutomaton game_of_life<CR>", "[L]ife" },
	}, {
		name = "Automaton",
		prefix = "<leader>a",
	}),
}
