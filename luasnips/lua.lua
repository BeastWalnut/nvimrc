local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local postfix = require("luasnip.extras.postfix").postfix
local fmt = require("luasnip.extras.fmt").fmt

local round_fun = fmt([[
---Rounds and returns `number`
---@param number number
---@return integer
function math.round(number)
	return math.floor(number + .5);
end]], {})

local contains_fun = fmt([[
---Returns true if `tbl` contains `val`
---@param tbl table
---@param val any
---@return boolean
function table.contains(tbl, val)
	---@diagnostic disable-next-line: no-unknown
	for _, v in pairs(tbl) do
		if v == val then
			return true;
		end
	end
	return false;
end]], {})

local contains_postfix = d(1, function(_, parent)
	return sn(1,
		fmt("table.contains(" .. parent.snippet.env.POSTFIX_MATCH .. ", {})", {
			i(1)
		})
	)
end)



return {
	s({ trig = "round" }, round_fun),
	s({ trig = "contains" }, contains_fun),
	postfix({
		trig = "@contains",
		match_patter = "[%w%.%_%-%(%)]+$",
	}, { contains_postfix }),
}
