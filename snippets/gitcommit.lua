local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local sfmta = require("utils.snippets").sfmta

local function csnip(name, node)
    return sfmta(name, "<><>: <>\n\n\n", {
        sn(1, node),
        c(2, {
            sn(nil, fmta("(<>)", i(1, "scope"))),
            t(""),
        }),
        i(3, "title"),
    })
end

return {
    csnip("cc", i(1, "type")),
    csnip("fix", t("fix")),
    csnip("feat", t("feat")),
    csnip("test", t("test")),
    csnip("perf", t("perf")),
    csnip("docs", t("docs")),
    csnip("style", t("style")),
    csnip("build", t("build")),
    csnip("chore", t("chore")),
    csnip("refactor", t("refactor")),
}
