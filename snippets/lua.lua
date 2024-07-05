local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require("utils.snippets")
local iseq = utils.i_sequence
local sfmta = utils.sfmta
local at_start = utils.at_start

local todo = "-- TODO"
local fun = sfmta(
    "function ()",
    [[
    function<>(<>)
        <>
    end]],
    {
        c(1, { sn(nil, { t(" "), i(1, "name") }), t("") }),
        iseq(2, "...", todo),
    }
)

local class = sfmta(
    "class",
    [[
    local <1> = {}
    <1>.__index = <1>

    function <1>.new(<>)
        <>
    end]],
    { iseq(1, "name", "...", todo) },
    { repeat_duplicates = true }
)

local sif = sfmta(
    "if .. then",
    [[
    if <> then
        <>
    end]],
    { iseq(1, "true", todo) }
)

local function else_cond()
    local node = vim.treesitter.get_node()
    if not node then
        return false
    elseif node:type() ~= "if_statement" then
        return false
    end
    local blocks = node:field("alternative")
    for _, block in ipairs(blocks) do
        if block:type() == "else_statement" then
            local range = { block:range() }
            local cursor = vim.api.nvim_win_get_cursor(0)
            return (cursor[1] <= range[1]) or (cursor[2] < range[2])
        end
    end
    return true
end

local elif = sfmta(
    { trig = "elseif .. then", show_condition = else_cond },
    [[
    elseif <> then
        <>]],
    { iseq(1, "true", todo) }
)

local fori = fmta(
    [[
    for <> = <>, <limit> do
        <>
    end]],
    {
        limit = c(3, {
            r(nil, "limit", i(1, "10")),
            sn(nil, fmta("<>, <>", { r(1, "limit"), i(2, "1") })),
        }),
        i(1, "i"),
        i(2, "1"),
        i(4, todo),
    }
)

local for_pairs = sfmta(
    "for .. pairs",
    [[
    for <>, <> in pairs(<>) do
        <>
    end]],
    { iseq(1, "k", "v", "t", todo) }
)

local for_ipairs = sfmta(
    "for .. ipairs",
    [[
    for i, <> in ipairs(<>) do
        <>
    end]],
    { iseq(1, "v", "list", todo) }
)

local swhile = sfmta(
    "while .. do",
    [[
        while <> do
            <>
        end]],
    { iseq(1, "true", todo) }
)

return {
    s({
        trig = "#!",
        snippetType = "autosnippet",
        condition = at_start,
    }, t("#!/usr/bin/env lua")),
    sfmta("req", 'require("<>")', i(1, "module")),
    sfmta("l=", "local <> = <>", { iseq(1, "name", "value") }),
    sfmta("lp", "local <>, <> = pcall(<>)", { iseq(1, "status", "value", "fun") }),
    fun,
    class,
    sif,
    elif,
    s("for i = ..", fori),
    s("fori", fori),
    for_pairs,
    for_ipairs,
    swhile,
}
