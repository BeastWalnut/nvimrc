function Set_map(keymaps, opts)
	opts = opts or {}
	local name
	if keymaps.name then
		name = "(" .. keymaps.name .. ") "
		keymaps.name = nil
	else
		name = ""
	end
	local mode = opts.mode or opts[1] or "n"
	local prefix = opts.prefix or ""
	opts[1] = nil
	opts.mode = nil
	opts.prefix = nil

	keymaps.name = nil
	for keys, km in pairs(keymaps) do
		local nopts = vim.tbl_extend("force", opts, { desc = name .. km[2] })
		vim.keymap.set(mode, prefix .. keys, km[1], nopts)
	end
end

-- VimRegex helpers
vim.keymap.set("n", "<leader>qr", [[:%s/\<<C-r><C-w>\>/]])
vim.keymap.set("c", ";\\", [[\(\)<left><left>]]) -- Insert \(\) to regex

-- Move highlighted lines up and down
Set_map({
	K = { ":m '<-2<Cr>gv=gv", "Move hightlight up" },
	J = { ":m '>+1<Cr>gv=gv", "Move hightlight down" },
}, {
	"v",
	silent = true,
	noremap = true,
})

-- Remove \n without moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line", noremap = true })

-- Move half a screen up/down
Set_map({
	["<C-u>"] = { "<C-u>zz", "Hafl screen up" },
	["<C-d>"] = { "<C-d>zz", "Half Screen down" },
}, { noremap = true })

-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "n", "nzzzv")

-- Supposedly evil operation fix
-- vim.keymap.set("n", "Q", "<nop>")

-- Run current lua program
-- vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>", { desc = "Source" })

-- Exit insert mode
Set_map({
	jk = { "<Esc>", "Exit insert mode" },
	kj = { "<Esc>", "Exit insert mode" },
}, { "i" })

-- Create/Delete Split windows
Set_map({
	name = "Splits",
	v = { "<C-w>v", "[V]ertically" },
	h = { "<C-w>s", "[H]orizontally" },
	e = { "<C-w>=", "[E]qualize" },
	q = { "<cmd>close<CR>", "[Q]uit" },
}, {
	prefix = "<leader>s",
	noremap = true,
	silent = true,
})

-- Splits/Window navigation
Set_map({
	name = "Split Nav",
	["<C-h>"] = { "<C-w>h", "Left" },
	["<C-j>"] = { "<C-w>j", "Down" },
	["<C-k>"] = { "<C-w>k", "Up" },
	["<C-l>"] = { "<C-w>l", "Right" },
}, {
	{ "n", "t" },
	noremap = true,
})

-- Clipboard Interactions
Set_map({
	y = { '"+y', "[Y]ank clipboard" },
	x = { "x", "Yank [x]" },
}, {
	{ "n", "v" },
	prefix = "<leader>",
	noremap = true,
})

-- Void copy/paste
Set_map({
	name = "Void",
	D = { [["_d]], "[D]elete" },
	x = { [["_x]], "X" },
	["<leader>p"] = { [["_dP"]], "[p]" },
}, {
	{ "n", "v" },
	noremap = true,
})

-- Number Interactions
Set_map({
	["+"] = { "<C-a>", "Increment Num" },
	["-"] = { "<C-x>", "Decrement Num" },
}, {
	prefix = "<leader>",
	noremap = true,
})
