local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local M = {}

function M.i_sequence(start, ...)
    local res = {}
    for k, v in pairs({ ... }) do
        local n = (start + k) - 1
        table.insert(res, i(n, v))
    end
    return unpack(res)
end

function M.at_start(line_to_cursor, matched_trigger)
    if line_to_cursor ~= matched_trigger then
        return false
    end
    return vim.api.nvim_win_get_cursor(0)[1] == 1
end

function M.sfmta(context, format, nodes, fopts, sopts)
    return s(context, fmta(format, nodes, fopts), sopts)
end

return M
