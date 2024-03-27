return {
	"folke/which-key.nvim",
	lazy = true,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		local keymap = {
			a = { name = "Automata" },
			t = { name = "Trouble" },
			e = { name = "File Explorer" },
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

		local presets = require("core.keymaps")

		for _, preset in ipairs(presets) do
			wk.register(preset.maps, preset.opts)
		end
	end,
}
