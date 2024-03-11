return {
	{
		"olimorris/onedarkpro.nvim",
		name = "onedark-pro",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catpuccin",
		lazy = false,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		tag = "v1.2.2",
		lazy = false,
		priority = 1000,
		opts = {
			groups = {
				comment = "DarkCyan",
			},
			highlight_groups = {
				Normal = { bg = "none" },
				NormalNC = { bg = "#232136" },
				LspInlayHint = { fg = "muted" },

				-- NOTE: Shit no work bro
				-- TelescopeBorder = { fg = "highlight_high", bg = "none" },
				-- TelescopeNormal = { bg = "none" },
				-- TelescopePromptNormal = { bg = "base" },
				-- TelescopeResultsNormal = { fg = "subtle", bg = "none" },
				-- TelescopeSelection = { fg = "text", bg = "base" },
				-- TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
