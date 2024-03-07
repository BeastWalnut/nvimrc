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
	end,
}
