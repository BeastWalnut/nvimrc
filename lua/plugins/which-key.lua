return {
	"folke/which-key.nvim",
	lazy = true,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		local keymap = {
			a = { name = "Automata" },
			t = { name = "Trouble" },
			u = { name = "UndoTree" },
			h = { name = "Harpoon" },
			f = { name = "Find" },
			c = { name = "Lsp" },
		}

		local key_opts = {
			"n",
			prefix = "<leader>",
		}

		wk.register(keymap, key_opts)
	end,
}
