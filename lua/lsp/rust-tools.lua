return {
	"simrat39/rust-tools.nvim",
	dependencies = { "nvim-lspconfig" },
	ft = { "rust", "toml" },
	opts = function()
		return {
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			},
			tools = {
				inlay_hints = {
					right_align = false,
					parameter_hints_prefix = " <- ",
					other_hints_prefix = " => ",
					highlight = "LspInlayHint",
				},
			},
		}
	end,
}

