local utils = require("utils.keymap")

-- VimRegex helpers
vim.keymap.set("n", "<leader>qr", [[:%s/\<<C-r><C-w>\>/]])
vim.keymap.set("c", ";\\", [[\(\)<left><left>]]) -- Insert \(\) to regex

-- Move highlighted lines up and down
utils.set({
    K = { ":m '<-2<Cr>gv=gv", "Move hightlight up" },
    J = { ":m '>+1<Cr>gv=gv", "Move hightlight down" },
}, {
    mode = "v",
})

-- Remove \n without moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line", noremap = true })

-- Move half a screen up/down
utils.set({
    ["<C-u>"] = { "<C-u>zz", "Half screen up" },
    ["<C-d>"] = { "<C-d>zz", "Half Screen down" },
})

-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "n", "nzzzv")

-- Supposedly evil operation fix
-- vim.keymap.set("n", "Q", "<nop>")

-- Exit insert mode
utils.set({
    jk = { "<Esc>", "Exit insert mode" },
    kj = { "<Esc>", "Exit insert mode" },
}, {
    mode = "i",
})

-- Create/Delete Split windows
utils.set({
    v = { "<C-w>v", "[V]ertically" },
    h = { "<C-w>s", "[H]orizontally" },
    e = { "<C-w>=", "[E]qualize" },
    q = { "<cmd>close<CR>", "[Q]uit" },
}, {
    name = "Splits",
    prefix = "<leader>s",
})

-- Clipboard Interactions
utils.set({
    y = { '"+y', "[Y]ank clipboard" },
    x = { "x", "Yank [x]" },
}, {
    mode = { "n", "v" },
    prefix = "<leader>",
})

-- Void copy/paste
utils.set({
    D = { [["_d]], "[D]elete" },
    x = { [["_x]], "X" },
    ["<leader>p"] = { [["_dP]], "Paste" },
}, {
    mode = { "n", "v" },
    name = "Void",
})

-- Number Interactions
utils.set({
    ["+"] = { "<C-a>", "Increment" },
    ["-"] = { "<C-x>", "Decrement" },
}, {
    prefix = "<leader>",
    name = "Number",
})

Gen_map = utils.generate
Set_map = utils.set
