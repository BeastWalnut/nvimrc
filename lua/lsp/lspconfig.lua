return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"fole/neodev.nvim",
		"nvim-telescope/telescope.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = augroup("LspOnAttach", {}),
			callback = function(e)
				local map_opts = {
					noremap = true,
					buffer = e.buf,
				}

				Set_map({
					["<M-q>"] = { vim.lsp.buf.format, "Code Format" },
					K = { vim.lsp.buf.hover, "Cursor Doc" },
				}, map_opts)

				map_opts[1] = "i"
				Set_map({
					["<C-h>"] = { vim.lsp.buf.signature_help, "Open lsp help" },
				}, map_opts)

				map_opts[1] = "n"
				Set_map({
					["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
					["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
				}, map_opts)

				map_opts.prefix = "g"
				Set_map({
					d = { "<cmd>Telescope lsp_definitions<CR>", "Peek cursor [D]eclaration" },
					D = { vim.lsp.buf.declaration, "[G]o [D]eclaration" },
					i = { "<cmd>Telescope lsp_implementations<CR>", "Peek cursor [I]mplementation" },
					I = { vim.lsp.buf.implementation, "[G]o [I]mplementation" },
					r = { vim.lsp.buf.references, "Cursor [R]eferences" },
				}, map_opts)

				map_opts[1] = { "n", "v" }
				map_opts.prefix = "<leader>"
				Set_map({
					ca = { vim.lsp.buf.code_action, "Show [C]ode [A]ctions" },
					rn = { vim.lsp.buf.rename, "Cursor [R]ename" },
					e = { vim.diagnostic.open_float, "Cursor Diagnostic" },
				}, map_opts)

				local lsp_format = augroup("LspFormat", {})
				vim.api.nvim_clear_autocmds({ group = lsp_format, buffer = e.buf })
				autocmd("BufWritePre", {
					group = lsp_format,
					buffer = e.buf,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end,
		})
	end,
}
