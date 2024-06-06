return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local none_ls = require("null-ls")
		local formatting = none_ls.builtins.formatting
		none_ls.setup({
			sources = {
				formatting.stylua,
				formatting.prettierd,
			},
		})
	end,
}
