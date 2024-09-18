local M = { "nvim-telescope/telescope.nvim" }

M.tag = "0.1.5"
M.cmd = "Telescope"
M.keys = Gen_map({
    f = { "<cmd>Telescope find_files<CR>", "[F]iles" },
    s = { "<cmd>Telescope live_grep<CR>", "[S]tring" },
    c = { "<cmd>Telescope grep_string<CR>", "[C]ursor string" },
    b = { "<cmd>Telescope buffers<CR>", "[B]uffers" },
    g = { "<cmd>Telescope git_files<CR>", "[G]it files" },
    k = { "<cmd>Telescope keymaps<CR>", "[K]eymaps" },
    h = { "<cmd>Telescope help_tags<CR>", "[H]elp" },
}, {
    name = "Find",
    prefix = "<leader>f",
})
M.opts = function()
    local actions = require("telescope.actions")
    local opts = {
        extensions = {
            file_browser = { mappings = { i = { ["<bs>"] = false } } },
        },
        pickers = { find_files = { follow = true } },
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
    return opts
end
M.config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
end

return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    M,
}
