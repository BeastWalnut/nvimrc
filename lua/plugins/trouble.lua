return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = Gen_map({
		w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "[W]orkspace" },
		q = { "<cmd>TroubleToggle quickfix<CR>", "[Q]uickfix" },
	}, {
		name = "Trouble",
		prefix = "<leader>t",
	}),
	opts = {},
}
