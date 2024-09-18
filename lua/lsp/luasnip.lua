local M = { "L3MON4D3/LuaSnip" }

M.version = "v2.*"
M.run = "make install_jsregexp"
M.opts = {
    updateevents = { "TextChanged", "TextChangedI" },
    enable_autosnippets = true,
}
M.config = function(_, opts)
    local ls = require("luasnip")
    ls.setup(opts)

    local function next_snip()
        ls.jump(1)
    end
    local function prev_snip()
        ls.jump(-1)
    end
    local function next_choice()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end
    local function prev_choice()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end

    Set_map({
        ["<M-k>"] = { next_snip, "Next Node" },
        ["<M-j>"] = { prev_snip, "Previous Node" },
        ["<M-l>"] = { next_choice, "Next Choice" },
        ["<M-h>"] = { prev_choice, "Prev Choice" },
    }, {
        name = "Luasnip",
        mode = { "n", "s", "i" },
    })

    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
end

return M
