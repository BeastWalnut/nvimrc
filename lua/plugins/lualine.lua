return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local lazy_status = require("lazy.status")
		return {
			options = { theme = "codedark" },
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "filetype" },
				},
			},
		}
	end,
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
