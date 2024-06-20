---@class (exact) VimMapOpt
---@field desc string?
---@field buffer number | nil
---@field noremap boolean
---@field silent boolean
---@field nowait boolean
---@field expr boolean

---@alias VimMode "n" | "i" | "v" | "s" | "t" | VimMode[]

---@class (exact) VimMap: VimMapOpt
---@field [1] string
---@field [2] string | fun()
---@field mode VimMode

---@class MapDef
---@field [1] string | fun()
---@field [2] string

---@class MapOpt: VimMapOpt
---@field mode VimMode?
---@field name string?
---@field prefix string?
---@field desc string?
local DEFAULT_OPTS = {
    mode = "n",
    prefix = "",
    noremap = true,
    silent = true,
    nowait = false,
    expr = false,
}

---@param keymaps MapDef
---@param opts MapOpt?
---@return VimMap[]
function Gen_map(keymaps, opts)
    opts = vim.tbl_extend("force", DEFAULT_OPTS, opts or {})
    local maps = {}
    local name = ""
    if vim.tbl_get(opts, "name") then
        name = "(" .. opts.name .. ") "
    end
    ---@param kmaps MapDef
    ---@param mopts MapOpt
    local function generate(kmaps, mopts)
        for trig, map in pairs(kmaps) do
            if type(trig) == "number" then
                goto continue
            end
            local ptrig = mopts.prefix .. trig
            generate(map, vim.tbl_extend("force", mopts, { prefix = ptrig }))
            local result = vim.tbl_extend("force", mopts, {
                ptrig,
                map[1],
                desc = name .. map[2],
            })
            result.name = nil
            result.prefix = nil
            table.insert(maps, result)
            ::continue::
        end
    end
    generate(keymaps, opts)
    return maps
end

---@param keymaps MapDef
---@param opts MapOpt?
function Set_map(keymaps, opts)
    local generated = Gen_map(keymaps, opts)
    for _, map in ipairs(generated) do
        local trig = map[1]
        local func = map[2]
        local mode = map.mode
        map[1], map[2], map.mode = nil, nil, nil
        vim.keymap.set(mode, trig, func, map)
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
    mode = "v",
})

-- Remove \n without moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line", noremap = true })

-- Move half a screen up/down
Set_map({
    ["<C-u>"] = { "<C-u>zz", "Half screen up" },
    ["<C-d>"] = { "<C-d>zz", "Half Screen down" },
})

-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "n", "nzzzv")

-- Supposedly evil operation fix
-- vim.keymap.set("n", "Q", "<nop>")

-- Exit insert mode
Set_map({
    jk = { "<Esc>", "Exit insert mode" },
    kj = { "<Esc>", "Exit insert mode" },
}, {
    mode = "i",
})

-- Create/Delete Split windows
Set_map({
    v = { "<C-w>v", "[V]ertically" },
    h = { "<C-w>s", "[H]orizontally" },
    e = { "<C-w>=", "[E]qualize" },
    q = { "<cmd>close<CR>", "[Q]uit" },
}, {
    name = "Splits",
    prefix = "<leader>s",
})

-- Clipboard Interactions
Set_map({
    y = { '"+y', "[Y]ank clipboard" },
    x = { "x", "Yank [x]" },
}, {
    mode = { "n", "v" },
    prefix = "<leader>",
})

-- Void copy/paste
Set_map({
    D = { [["_d]], "[D]elete" },
    x = { [["_x]], "X" },
    ["<leader>p"] = { [["_dP]], "Paste" },
}, {
    mode = { "n", "v" },
    name = "Void",
})

-- Number Interactions
Set_map({
    ["+"] = { "<C-a>", "Increment" },
    ["-"] = { "<C-x>", "Decrement" },
}, {
    prefix = "<leader>",
    name = "Number",
})
