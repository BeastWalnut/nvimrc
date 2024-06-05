return {
	"mbbill/undotree", -- Undo Tree.
	event = { "InsertEnter" },
	keys = Gen_map({
		u = { "<Cmd>UndotreeToggle<CR>", "Toggle" },
		q = { "<Cmd>UndotreeHide<CR>", "[Q]uit" },
	}, {
		name = "Undo",
		prefix = "<leader>u",
	}),
}
