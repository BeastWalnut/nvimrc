local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local r = ls.restore_node
local utils = require("utils.snippets")
local iseq = utils.i_sequence
local sfmta = utils.sfmta

local todo = "// TODO"
local main = sfmta(
    "main",
    [[
        package main

        import "fmt"

        func main() {
            <>
        }]],
    i(0, 'fmt.Println("Hello, World!")')
)

local func = sfmta(
    "func",
    [[
    func<>(<>)<> {
        <>
    }]],
    {
        c(1, {
            sn(nil, { t(" "), r(1, "name", i(1, "name")) }),
            sn(nil, { t(" ("), i(1), t(") "), r(2, "name") }),
            t(""),
        }),
        i(2),
        c(3, { t(""), sn(nil, { t(" "), i(1, "type") }) }),
        i(4, todo),
    }
)

local enum = sfmta(
    "enum",
    [[
    type <1> <>
    const (
        <> <1> = <4><>
    )]],
    { iseq(1, "type", "int", "undefined", "iota", "") },
    { repeat_duplicates = true }
)

local import = sfmta(
    "import",
    [[
    import (
        "<>"
    )]],
    { i(1, "package") }
)

local struct = sfmta(
    "struct",
    "struct{<>}",
    c(1, {
        sn(nil, { t({ "", "    " }), i(1, "field"), t(" "), i(2, "type"), t({ "", "" }) }),
        t(""),
    })
)

local switch = sfmta(
    "switch",
    [[
    switch <> {
    case <>:
        <>
    default:
        <>
    }]],
    { iseq(1, "expr", "condition", todo, todo) }
)

local select = sfmta(
    "select",
    [[
    select {
    case <>:
        <>
    }]],
    { iseq(1, "condition", todo) }
)

local case = sfmta("case", "case <>:\n\t<>", { iseq(1, "condition", todo) })

local fors = sfmta(
    "for",
    [[
    for <> {
        <>
    }]],
    { iseq(1, "true", "") }
)

local fori = sfmta(
    "fori",
    [[
    for <1> := <2>; <1> << <3>; <1><4> {
        <5>
    }]],
    { iseq(1, "i", "0", "count", "++", todo) },
    { repeat_duplicates = true }
)

local ifs = sfmta(
    "if",
    [[
    if <> {
        <>
    }]],
    { iseq(1, "true", todo) }
)

local elses = sfmta(
    "else",
    [[
    else {
        <>
    }]],
    i(1, todo)
)

local elif = sfmta(
    "else-if",
    [[
    else if <> {
        <>
    }]],
    { iseq(1, "true", todo) }
)

local if_ok = sfmta(
    "if-ok",
    [[
    if <>, ok := <>[<>]; ok {
        <>
    }]],
    { iseq(1, "value", "map", "key", todo) }
)

return {
    sfmta("const", "const <> = <>", {
        iseq(1, "NAME", "value"),
    }),
    sfmta("var", "var <> <>", {
        iseq(1, "name", "type"),
    }),
    sfmta("map", "map[<>]<>", { iseq(1, "int", "type") }),
    sfmta("chan", "chan <>", i(1, "type")),
    main,
    func,
    enum,
    import,
    struct,
    switch,
    select,
    case,
    fors,
    fori,
    ifs,
    elses,
    elif,
    if_ok,
}
