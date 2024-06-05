return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = Gen_map({
		["<leader>hh"] = { nil, "Toggle" },
		["<leader>ha"] = { nil, "[A]dd" },
		["]h"] = { nil, "Next" },
		["[h"] = { nil, "Previous" },
		gh = { nil, "[G]o to" },
	}, {
		name = "Harpoon",
	}),
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { settings = { sync_on_ui_close = true } },
	config = function(_, opts)
		local harpoon = require("harpoon")
		harpoon:setup(opts)

		local map_opts = { ui_nav_wrap = true }
		local function toggle_menu()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end

		local function add_to_list()
			harpoon:list():add()
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
			h = { toggle_menu, "Toggle" },
			a = { add_to_list, "[A]dd" },
		}, {
			name = "Harpoon",
			prefix = "<leader>h",
		})

		Set_map({
			["]h"] = { next_harp, "Next" },
			["[h"] = { prev_harp, "Previous" },
			["gh"] = { select_harp, "[G]o to" },
		}, {
			name = "Harpoon",
		})
	end,
}
