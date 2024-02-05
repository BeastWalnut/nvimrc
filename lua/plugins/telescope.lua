return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<CR>",   desc = "[F]ind [F]iles" },
		{ "<leader>fs", "<cmd>Telescope live_grep<CR>",    desc = "[F]ind [S]tring" },
		{ "<leader>fc", "<cmd>Telescope grep_string<CR>",  desc = "[F]ind [C]ursor string" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>",      desc = "[F]ind [B]uffers" },
		{ "<leader>fg", "<cmd>Telescope git_files<CR>",    desc = "[F]ind [G]it files" },
		{ "<leader>fk", "<cmd>Telescope keymaps<CR>",      desc = "[F]ind [K]eymaps" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>",    desc = "[F]ind [H]elp" },
		{ "<leader>e",  "<cmd>Telescope file_browser<CR>", desc = "File [E]xplore" },
	},
	opts = {
		extensions = {},
		pickers = {
			find_files = {
				follow = true
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		opts.extensions.file_browser = {
			mappings = {
				i = {
					["<bs>"] = false,
				},
				n = {
					l = actions.select_default,
				},
			},
		}

		opts.defaults = {
			path_display = { shorten = 3 },
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-q>"] = actions.add_selected_to_qflist + actions.open_qflist,
				},
			},
		}
		telescope.setup(opts)

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
	end,
}
