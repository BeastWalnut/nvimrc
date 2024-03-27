return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	run = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function(_, opts)
		local ls = require("luasnip")
		ls.setup(opts)
		ls.config.set_config({
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})

		local function next_snip()
			ls.jump(1)
		end
		local function prev_snip()
			ls.jump(-1)
		end

		Set_map({
			name = "Luasnip",
			["<M-k>"] = { next_snip, "Next" },
			["<M-j>"] = { prev_snip, "Previous" },
		}, {
			{ "s", "i" },
		})

		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").lazy_load({ paths = { "./luasnips" } })
		require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })
	end,
}
