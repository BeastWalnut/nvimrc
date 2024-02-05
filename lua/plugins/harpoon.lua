return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
        { "<leader>hh", desc = "[h] [H]arpoon" },
        { "<leader>ha", desc = "[H]arpoon [A]dd" },
        { "]h",         desc = "[H]arpoon next" },
        { "[h",         desc = "[H]arpoon prev" },
        { "gh",         desc = "[H]arpoon [G]o to <count>" },
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
            h = { toggle_menu, "[h] [H]arpoon" },
            a = { add_to_list, "[H]arpoon [A]dd" },
        }, {
            prefix = "<leader>h",
            noremap = true,
        })

        vim.keymap.set("n", "]h", next_harp, { desc = "Next [H]arpoon" })
        vim.keymap.set("n", "[h", prev_harp, { desc = "Prev [H]arpoon" })
        vim.keymap.set("n", "gh", select_harp, { desc = "[G]o [H]arpoon at <count>" })
    end,
}
