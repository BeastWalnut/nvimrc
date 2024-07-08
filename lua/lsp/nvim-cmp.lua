return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
        local icons = {
            -- Text = "󱀍",
            -- Interface = "",
            -- Value = "󰎠",
            -- Color = "󰏘",
            -- File = "󰈙",
            -- Folder = "󰉋",
            Constructor = "",
            Class = "∴",
            Struct = "",
            Enum = "",
            EnumMember = "",
            Unit = "()",
            Field = "→",
            Property = "∷",
            Method = "𝘮",

            Module = "",
            Snippet = "",
            Keyword = "",

            Constant = "π",
            Variable = "𝓧",
            Reference = "⊸",
            Function = "λ",

            Event = "",
            Operator = "±",
            TypeParameter = "",
        }

        return {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            confirmation = { completeopt = "menu,menuone,noselect" },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    local kind = vim_item.kind

                    vim_item.kind = icons[kind] or "?"
                    local item = entry:get_completion_item()

                    local menu = item.detail or kind
                    vim_item.menu = "│ " .. menu

                    local source = entry.source.name
                    if source == "luasnip" or source == "nvim_lsp" then
                        vim_item.dup = nil
                    end

                    return vim_item
                end,
            },
        }
    end,
    config = function(_, opts)
        --Colors
        vim.api.nvim_set_hl(0, "CmpItemKindEnum", { link = "@lsp.type.enum" })
        vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "@lsp.type.enumMember" })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct", { link = "Structure" })
        vim.api.nvim_set_hl(0, "CmpItemKindClass", { link = "@class" })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "@method" })
        vim.api.nvim_set_hl(0, "CmpItemKindField", { link = "@field" })

        vim.api.nvim_set_hl(0, "CmpItemKindConstant", { link = "Constant" })
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { link = "Keyword" })

        vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA" })
        local cmp = require("cmp")

        opts.mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-m>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
        })

        opts.sources = cmp.config.sources({
            { name = "luasnip" },
            { name = "lazydev" },
            { name = "nvim_lsp" },
        }, {
            { name = "buffer" },
            { name = "path" },
        })

        cmp.setup(opts)
    end,
}
