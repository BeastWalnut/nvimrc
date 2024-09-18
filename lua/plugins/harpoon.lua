local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"
M.keys = Gen_map({
    ["<leader>hh"] = { nil, "Toggle" },
    ["<leader>ha"] = { nil, "[A]dd" },
    ["]h"] = { nil, "Next" },
    ["[h"] = { nil, "Previous" },
}, { name = "Harpoon" })
M.opts = {
    settings = {
        sync_on_ui_close = true,
    },
}
M.config = function(_, opts)
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
    }, {
        name = "Harpoon",
    })
end

return {
    "nvim-lua/plenary.nvim",
    M,
}
