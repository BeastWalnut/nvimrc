return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = function()
		return {
			tool_installer = {
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
				},
			},
			servers = {
				lua_ls = {},
				eslint = {},
				jsonls = {},
				tsserver = {},
				rust_analyzer = {},
				efm = {},
			},
			lsp = {}
		}
	end,
	config = function(_, opts)
		local mason = require("mason")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			}
		})

		local servers = opts.servers

		opts.lsp.ensure_installed = vim.tbl_keys(servers)
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			automatic_installation = true,
		})

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		mason_lspconfig.setup_handlers({
			function(name)
				local server = servers[name] or {}
				server.capabilities = capabilities
				require("lspconfig")[name].setup(server)
			end,
			rust_analyzer = function() end,
		})
		require("mason-tool-installer").setup(opts.tool_installer)
	end,
}
