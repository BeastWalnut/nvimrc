return {
	"toppair/peek.nvim",
	ft = { "markdown" },
	build = "deno task --quiet build:fast",
	config = function()
		local peek = require("peek")
		peek.setup()
		-- refer to `configuration to change defaults`
		vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
		vim.api.nvim_create_user_command("PeekClose", peek.close, {})
	end,
}
