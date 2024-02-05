return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "codedark",
		},
	},
	config = function(_, opts)
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		opts.sections = {
			lualine_x = {
				{
					lazy_status.updates,
					cond = lazy_status.has_updates,
					color = { fg = "#ff9e64" },
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
		}
		lualine.setup(opts)
	end,
}
