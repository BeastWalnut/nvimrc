return {
	"folke/neodev.nvim",
	ft = { "lua" },
	opts = {
		override = function(root_dir, library)
			if root_dir:find("nvim") then
				library.enabled = true
				library.plugins = true
			end
		end,
		lspconfig = false
	}
}
