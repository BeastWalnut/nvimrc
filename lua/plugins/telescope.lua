local telescope = {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    keys = Gen_map({
        f = { "<cmd>Telescope find_files<CR>", "[F]iles" },
        s = { "<cmd>Telescope live_grep<CR>", "[S]tring" },
        c = { "<cmd>Telescope grep_string<CR>", "[C]ursor string" },
        b = { "<cmd>Telescope buffers<CR>", "[B]uffers" },
        g = { "<cmd>Telescope git_files<CR>", "[G]it files" },
        k = { "<cmd>Telescope keymaps<CR>", "[K]eymaps" },
        h = { "<cmd>Telescope help_tags<CR>", "[H]elp" },
        e = { "<cmd>Telescope file_browser<CR>", "[E]xplore" },
    }, {
        name = "Find",
        prefix = "<leader>f",
    }),
    cmd = "Telescope",
    config = function()
        local actions = require("telescope.actions")
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                path_display = { shorten = 3 },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.add_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                file_browser = { mappings = { i = { ["<bs>"] = false } } },
            },
            pickers = { find_files = { follow = true } },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
    end,
}
return {
    {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    telescope,
}
