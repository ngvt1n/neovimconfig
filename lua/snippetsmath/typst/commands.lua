local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
-- local get_visual = utils.get_visual
local in_mathzone = utils.in_mathzone
-- local line_begin = require("luasnip.extras.expand_conditions").line_begin
local fs = function(_, snip)
  return snip.captures[1]
end

return {
  s(
    { trig = "$(.-)%s+and%s", regTrig = true, wordTrig = false },
    fmta("$<>$ and $", { f(fs) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "$(.-)%s+are%s", regTrig = true, wordTrig = false },
    fmta("$<>$ are $", { f(fs) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "$(.-)%s+is%s", regTrig = true, wordTrig = false },
    fmta("$<>$ is $", { f(fs) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "$(.-)%s+where%s", regTrig = true, wordTrig = false },
    fmta("$<>$ where $", { f(fs) }),
    { condition = in_mathzone }
  ),
}
