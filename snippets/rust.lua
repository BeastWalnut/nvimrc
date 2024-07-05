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

local function pub(n)
    return c(n, {
        t(""),
        t("pub "),
        sn(nil, fmta("pub(<>) ", i(1))),
    })
end

local struct = sfmta(
    "struct",
    [[
    #[derive(Debug)]
    <>struct <>]],
    {
        pub(1),
        c(2, {
            sn(nil, fmta("<> {\n    <>\n}", { r(1, "name", i(nil, "Name")), i(2) })),
            sn(nil, fmta("<>(<>);", { r(1, "name"), i(2) })),
            sn(nil, fmta("<>;", r(1, "name"))),
        }),
    }
)

local enum = sfmta(
    "enum",
    [[
    #[derive(Debug)]
    <>enum <> {
        <>
    }]],
    { pub(1), iseq(2, "Name", "") }
)

local trait = sfmta(
    "trait",
    [[
    <>trait <> {
        <>
    }]],
    { pub(1), iseq(2, "Trait", "// add code here") }
)

local impl = sfmta(
    "impl",
    [[
    impl <> {
        <>
    }]],
    { iseq(1, "Type", "// add code here") }
)

local impl_trait = sfmta(
    "impl-trait",
    [[
    impl <> for <> {
        <>
    }]],
    { iseq(1, "Trait", "Type", "// add code here") }
)

local fn = sfmta(
    "fn",
    [[
    <>fn <>(<>)<> {
        <>
    }]],
    {
        pub(1),
        i(2, "name"),
        i(3),
        c(4, { sn(nil, { t(" -> "), i(1, "RetType") }), i("") }),
        i(5, "todo!();"),
    }
)

local bench = sfmta(
    "bench",
    [[
    #[bench]
    fn <>(b: &mut test::Bencher) {
        <>
    }]],
    { iseq(1, "name", "") }
)

local test = sfmta(
    "test",
    [[
    #[test]
    fn <>() {
        <>
    }]],
    { iseq(1, "name", "todo!();") }
)

local modtest = sfmta(
    "modtest",
    [[#[cfg(test)]
    mod test {
        <>
    }]],
    i(1)
)

local macro_rules = sfmta(
    "macro_rules",
    [[
    macro_rules! <> {
        (<>) =>> {
            <>
        };
    }
    ]],
    { iseq(1, "name", "", "") }
)

local sfor = sfmta(
    "for",
    [[
    for <> in <> {
        <>
    }]],
    { iseq(1, "pat", "expr", "todo!()") }
)

local match = sfmta(
    "match",
    [[
    match <> {
        <> =>> <>
    }]],
    { iseq(1, "expr", "_", "todo!()") }
)

local function cond(kw)
    return fmta(kw .. " <> {\n    <>\n}", {
        iseq(1, "true", "todo!()"),
    })
end

local function cond_let(kw)
    return fmta(kw .. " let <> = <> {\n    <>\n}", {
        iseq(1, "Some(pat)", "expr", "todo!();"),
    })
end

return {
    -- Atributes
    sfmta("allow", "#![allow(<>)]", i(1, "...")),
    sfmta("deny", "#![deny(<>)]", i(1, "...")),
    sfmta("warn", "#![warn(<>)]", i(1, "...")),
    sfmta("derive", "#[derive(<>)]", i(1, "debug")),

    -- Definitions
    sfmta("type", "type <> = <>;", { iseq(1, "Alias", "Type") }),
    sfmta("const", "const <>: <> = <>;", { iseq(1, "CONST", "Type", "init") }),
    sfmta("static", "static <>: <> = <>;", { iseq(1, "STATIC", "Type", "init") }),
    struct,
    enum,
    trait,
    impl,
    impl_trait,
    fn,
    bench,
    test,
    modtest,
    macro_rules,

    -- Expressions
    s("if", cond("if")),
    s("while", cond("while")),
    s("if let", cond_let("if")),
    s("while let", cond_let("while")),
    sfor,
    match,
}
