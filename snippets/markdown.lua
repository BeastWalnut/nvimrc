local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local utils = require("utils.snippets")
local iseq = utils.i_sequence
local sfmta = utils.sfmta

return {
    s("tip", t("> [!TIP] ")),
    s("note", t("> [!NOTE] ")),
    s("warning", t("> [!WARNING] ")),
    sfmta("bold", "**<>**", i(1)),
    sfmta("italic", "*<>*", i(1)),
    sfmta("strike", "~~<>~~", i(1)),
    sfmta("link", "[<>](<>)", { iseq(1, "text", "url") }),
    sfmta(
        "code",
        [[
        ```<>
        <>
        ```]],
        { iseq(1, "language", "") }
    ),
    sfmta(
        "table",
        [[
        | <> | <> |
        | ------- | ------- |]],
        { iseq(1, "Column1", "Column2") },
        { trim_empty = false }
    ),
    s({
        trig = "br",
        snippetType = "autosnippet",
    }, t("<br>")),
}
