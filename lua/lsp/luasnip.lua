return {
	"L3MON4D3/LuaSnip",
	lazy = true,
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
			["<M-k>"] = { next_snip, desc = "Jump to next snip" },
			["<M-j>"] = { prev_snip, desc = "Jump to prev snip" },
		}, {
			{ "s", "i" },
		})

		require("luasnip.loaders.from_vscode").lazy_load({ path = "./vssnips" })
		require("luasnip.loaders.from_lua").lazy_load({ path = "./luasnips" })
		require("luasnip.loaders.from_snipmate").lazy_load({ path = "./snippets" })
	end,
}

