local ls = require("luasnip")
local s = ls.snippet
local p = require("luasnip.extras").partial

return {
    s({
        trig = "diso",
        desc = "ISO date time stamp",
    }, { p(vim.fn.strftime, "%Y-%m-%dT%H:%M:%S") }),
    s({
        trig = "date",
        desc = "Date in (Y-m-d) format",
    }, { p(vim.fn.strftime, "%Y-%m-%d") }),
    s({
        trig = "dateDMY",
        desc = "Date in (DD/MM/YY) format",
    }, { p(vim.fn.strftime, "%d/%m/%y") }),
    s({
        trig = "time",
        desc = "Time in (H:M) format",
    }, { p(vim.fn.strftime, "%H:%M") }),
    s({
        trig = "timeHMS",
        desc = "Time in (H:M:S) format",
    }, { p(vim.fn.strftime, "%H:%M:%S") }),
    s({
        trig = "datetime",
        desc = "Date in (Y-m-d H:M) format",
    }, { p(vim.fn.strftime, "%Y-%m-%d %H:%M") }),
}
