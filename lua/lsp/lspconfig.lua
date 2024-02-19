return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",

		"nvim-telescope/telescope.nvim",
		"creativenull/efmls-configs-nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		mason = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		servers = {
			efm = {},
			lua_ls = {
				settings = {
					Lua = {
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "tab",
								indent_size = "4",
							}
						},
						completion = { callSnippet = "Replace", },
						diagnostics = {
							-- ["codestyle-check"] = "Opened",
							neededFileStatus = { ["no-unknown"] = "Opened", },
							groupSeverity = {
								duplicate = "Error",
								ambiguity = "Error",
								strong = "Error",
								["type-check"] = "Opened",
							},
							severity = { ["ambiguity-1"] = "Warning!", },
							unusedLocalExclude = { "_*" },
						},
					}
				}
			},
			eslint = {},
			jsonls = {},
			jdtls = {},
			tsserver = {},
			rust_analyzer = {},
		},
		lsp = {
			automatic_installation = true,
		},
		tool_installer = {
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
			},
		},
	},
	config = function(_, opts)
		local mason = require("mason")
		mason.setup(opts.mason)

		opts.lsp.ensure_installed = vim.tbl_keys(opts.servers)
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup(opts.lsp)

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local servers = opts.servers
		servers.lua_ls = {
			before_init = require("neodev.lsp").before_init,
		}


		local lspconfig = require("lspconfig")
		mason_lspconfig.setup_handlers({
			function(name)
				local server = servers[name] or {}
				server.capabilities = capabilities
				lspconfig[name].setup(server)
			end,
			rust_analyzer = function() end,
		})

		local mason_tool = require("mason-tool-installer")

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = augroup("LspOnAttach", {}),
			callback = function(e)
				local map_opts = {
					noremap = true,
					buffer = e.buf,
					prefix = "g",
				}

				Set_map({
					d = { "<cmd>Telescope lsp_definitions<CR>", "Peek cursor [D]eclaration" },
					D = { vim.lsp.buf.declaration, "Go to [D]eclaration" },
					i = { "<cmd>Telescope lsp_implementations<CR>", "Peek cursor [I]mplementation" },
					I = { vim.lsp.buf.implementation, "Go to [I]mplementation" },
					r = { vim.lsp.buf.references, "Cursor [R]e[f]erences" },
				}, map_opts)

				map_opts.prefix = "<leader>c"
				Set_map({
					name = "Lsp",
					d = { vim.diagnostic.open_float, "[C]ursor [D]iagnostic" },
					f = { vim.lsp.buf.format, "[C]ode [F]ormat" },
				}, map_opts)

				map_opts[1] = { "n", "v" }
				Set_map({
					name = "Lsp",
					a = { vim.lsp.buf.code_action, "Show [C]ode [A]ctions" },
				}, map_opts)

				map_opts.prefix = "<leader>"
				Set_map({
					r = { vim.lsp.buf.rename, "[C]ursor [R]ename" },
					k = { vim.lsp.buf.hover, "[C]ursor Doc" },
				}, map_opts)

				map_opts[1] = "i"
				map_opts.prefix = nil
				Set_map({
					["<C-h>"] = { vim.lsp.buf.signature_help, "Open lsp help" },
				}, map_opts)

				map_opts[1] = nil
				Set_map({
					["[d"] = { vim.diagnostic.goto_prev, "Jumpt to prev diagnostic" },
					["]d"] = { vim.diagnostic.goto_next, "Jump to next diagnostic" },
				}, map_opts)

				local lsp_format = augroup("LspFormat", {})
				vim.api.nvim_clear_autocmds({ group = lsp_format, buffer = e.buf })
				autocmd("BufWritePre", {
					group = lsp_format,
					buffer = e.buf,
					callback = function() vim.lsp.buf.format() end
				})
			end,
		})

		mason_tool.setup(opts.tool_installer)
	end,
}
