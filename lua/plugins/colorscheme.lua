return {
	{ "olimorris/onedarkpro.nvim", name = "onedarkpro", lazy = false },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		opts = {
			groups = { comment = "DarkCyan" },
			highlight_groups = {
				Normal = { bg = "none" },
				NormalNC = { bg = "#232136" },
				Todo = { fg = "iris" },
				["@comment.todo"] = { link = "Todo" },
				["@comment.note"] = { link = "@text.note" },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
