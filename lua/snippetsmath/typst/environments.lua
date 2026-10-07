local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
local get_visual = utils.get_visual
local in_mathzone = utils.in_mathzone
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {}, {
  s("nn",
    fmta(
      [[
        $
        <>
        $
        <>
      ]],
      {
        i(1),
        i(2),
      }
    ),
    { condition = line_begin - in_mathzone }
  ),
  s("nn",
    {
      t({ "", "$", "   " }),
      i(1),
      t({ "", "$", "" }),
      i(0)
    },
    { condition = -line_begin - in_mathzone }
  ),
  s("mm",
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
