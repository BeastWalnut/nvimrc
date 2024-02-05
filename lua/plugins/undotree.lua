return {
	"mbbill/undotree", -- Undo Tree.
	event = { "InsertEnter" },
	keys = {
		{ "<leader>uu", "<cmd>UndotreeShow<CR><cmd>UndotreeFocus<CR>", desc = "[u] [U]ndo" },
		{ "<leader>uq", "<cmd>UndotreeHide<CR>", desc = "[U]ndo [Q]uit" },
	},
}

