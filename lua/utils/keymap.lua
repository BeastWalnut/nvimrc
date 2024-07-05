---@alias VimMode "n" | "i" | "v" | "s" | "t" | VimMode[]

---@class (exact) VimMap: vim.keymap.set.Opts
---@field [1] string         # lhs
---@field [2] string | fun() # rhs
---@field mode VimMode       # mode

---@class MapDef
---@field [1] string | fun() # rhs
---@field [2] string         # desc

---@class MapOpt: vim.keymap.set.Opts
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

---@param keymaps MapDef[]
---@param opts MapOpt?
---@return VimMap[]
local function generate(keymaps, opts)
    opts = vim.tbl_extend("force", DEFAULT_OPTS, opts or {})
    local maps = {}
    local name = ""
    if vim.tbl_get(opts, "name") then
        name = "(" .. opts.name .. ") "
    end
    ---@param kmaps MapDef
    ---@param mopts MapOpt
    local function impl(kmaps, mopts)
        for trig, map in pairs(kmaps) do
            if type(trig) == "number" then
                goto continue
            end
            local ptrig = mopts.prefix .. trig
            impl(map, vim.tbl_extend("force", mopts, { prefix = ptrig }))
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
    impl(keymaps, opts)
    return maps
end

---@param keymaps MapDef[]
---@param opts MapOpt?
local function set(keymaps, opts)
    local generated = generate(keymaps, opts)
    for _, map in ipairs(generated) do
        local trig = map[1]
        local func = map[2]
        local mode = map.mode
        map[1], map[2], map.mode = nil, nil, nil
        vim.keymap.set(mode, trig, func, map)
    end
end

return {
    generate = generate,
    set = set,
}
