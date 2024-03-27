return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
		{ "<leader>hh", desc = "(Harpoon) Toggle" },
		{ "<leader>ha", desc = "(Harpoon) [A]dd" },
		{ "]h", desc = "(Harpoon) Next" },
		{ "[h", desc = "(Harpoon) Previous" },
		{ "gh", desc = "(Harpoon) [G]o to" },
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		settings = {
			sync_on_ui_close = true,
		},
	},
	config = function(_, opts)
		local harpoon = require("harpoon")
		harpoon:setup(opts)

		local map_opts = { ui_nav_wrap = true }
		local function toggle_menu()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end

		local function add_to_list()
			harpoon:list():append()
		end

		local function next_harp()
			harpoon:list():next(map_opts)
		end

		local function prev_harp()
			harpoon:list():prev(map_opts)
		end

		local function select_harp()
			harpoon:list():select(vim.v.count or 1)
		end

		Set_map({
			name = "Harpoon",
			h = { toggle_menu, "Toggle" },
			a = { add_to_list, "[A]dd" },
		}, { prefix = "<leader>h" })

		Set_map({
			name = "Harpoon",
			["]h"] = { next_harp, "Next" },
			["[h"] = { prev_harp, "Previous" },
			["gh"] = { select_harp, "[G]o to" },
		})
	end,
}
