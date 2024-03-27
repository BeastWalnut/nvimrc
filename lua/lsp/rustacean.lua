---@type LazySpec
return {
	"mrcjkb/rustaceanvim",
	version = "^4",
	ft = "rust",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		---@type RustaceanConfig
		vim.g.rustaceanvim = {
			tools = { enable_clippy = true },
		}
	end,
}
