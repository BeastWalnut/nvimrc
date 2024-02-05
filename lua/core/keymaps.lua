function Set_map(keymaps, opts)
	local name = keymaps.name
	keymaps.name = nil

	local mode = opts[1] or "n"
	local prefix = opts.prefix or ""
	opts[1] = nil
	opts.prefix = nil

	for key, keymap in pairs(keymaps) do
		opts.desc = keymap[2]
		vim.keymap.set(mode, prefix .. key, keymap[1], opts)
	end

	opts.desc = nil
	opts[1] = mode
	opts.prefix = prefix

	keymaps.name = name
end

-- Move highlighted lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Remove \n without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Move half a screen up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "n", "nzzzv")

-- Supposedly evil operation fix
-- vim.keymap.set("n", "Q", "<nop>")

-- Run current lua program
-- vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>", { desc = "Source" })

-- Exit insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit Insert mode" })

-- Create/Delete Split windows
local window = {
	maps = {
		name = "Splits",
		v = { "<C-w>v", "[S]plit [V]ertically" },
		h = { "<C-w>s", "[S]plit [H]orizontally" },
		e = { "<C-w>=", "[S]plit [E]qualize" },
		q = { "<cmd>close<CR>", "[S]plit [Q]" },
	},
	opts = {
		prefix = "<leader>s",
		noremap = true,
		silent = true,
	},
}

local window_nav = {
	maps = {
		name = "Split Nav",
		["<C-h>"] = { "<C-w>h", "Move to left window" },
		["<C-j>"] = { "<C-w>j", "Go to window below" },
		["<C-k>"] = { "<C-w>k", "Go to window above" },
		["<C-l>"] = { "<C-w>l", "Move to right window" },
	},
	opts = {
		{ "n", "t" },
		noremap = true,
	},
}

-- Clipboard Interactions
local clip = {
	maps = {
		y = { '"+y', "Clip [Y]ank" },
		x = { "x", "Yank [x]" },
	},
	opts = {
		{ "n", "v" },
		prefix = "<leader>",
		noremap = true,
	},
}

-- Void copy/paste
local void = {
	maps = {
		name = "Void",
		D = { [["_d]], "void [D]" },
		x = { [["_x]], "void [X]" },
		["<leader>p"] = { [["_dP"]], "void [p]" },
	},
	opts = {
		{ "n", "v" },
		noremap = true,
	},
}

-- Numbers
local numbers = {
	maps = {
		["+"] = { "<C-a>", "Increment Num" },
		["-"] = { "<C-x>", "Decrement Num" },
	},
	opts = {
		prefix = "<leader>",
		noremap = true,
	},
}

Set_map(window.maps, window.opts)
Set_map(window_nav.maps, window_nav.opts)
Set_map(clip.maps, clip.opts)
Set_map(void.maps, void.opts)
Set_map(numbers.maps, numbers.opts)

return {
	-- buffer,
	window,
	window_nav,
	clip,
	void,
	numbers,
}
