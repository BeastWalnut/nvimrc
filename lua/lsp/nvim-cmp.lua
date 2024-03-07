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
		-- other symbols that might be useful for something: -- ⊕ † ፨ ᯾ ⁂ ∎ ∹ ☖ ⚐ 🕮 🗈 🗉 🗈 🗉 ⬠  ⬡  ⮺  ⮻ ⯐  ⯒ ⟡ ✐  ✎ ꒾꙳ ꥟ ⤙ ⤚ ⤛ ⤜

		vim.api.nvim_set_hl(0, "CmpItemKindEnum", { link = "@lsp.type.enum" })
		vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "@lsp.type.enumMember" })
		vim.api.nvim_set_hl(0, "CmpItemKindStruct", { link = "Structure" })
		vim.api.nvim_set_hl(0, "CmpItemKindClass", { link = "@class" })
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "@method" })
		vim.api.nvim_set_hl(0, "CmpItemKindField", { link = "@field" })

		vim.api.nvim_set_hl(0, "CmpItemKindConstant", { link = "Constant" })
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { link = "Keyword" })

		vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA" })

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
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					local kind = vim_item.kind

					vim_item.kind = icons[kind] or "?"
					vim_item.menu = "| (" .. kind .. ")"

					local item = entry:get_completion_item()

					if item.detail then
						vim_item.menu = item.detail
					end

					local source = entry.source.name
					if source == "luasnip" or source == "nvim_lsp" then
						vim_item.dup = 0
					end

					return vim_item
				end
			},
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
