return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function(_, _)
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            confirmation = { completeopt = "menu,menuone,noselect" },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-m>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<S-space>"] = cmp.mapping.abort(),
            }),
            sources = cmp.config.sources({
                { name = "luasnip",  priority = 10 },
                { name = "nvim_lsp", priority = 5 },
                { name = "path" },
            }, {
                { name = "buffer" },
            }),
        })
    end,
}
