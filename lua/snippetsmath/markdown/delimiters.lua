local M
local N
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
local get_visual = utils.get_visual
local in_mathzone = utils.in_mathzone
local line_begin = require("luasnip.extras.expand_conditions").line_begin

M = {}
N = {
  s("lr()",
    fmta("<><>", {
      c(1, {
        sn(nil, { t "\\left(", i(1), t "\\right)" }),
        sn(nil, { t "\\left[", i(1), t "\\right]" }),
        sn(nil, { t "\\left{", i(1), t "\\right}" }),
        sn(nil, { t "\\left|", i(1), t "\\right|" }),
      }),
      i(0),
    }),
    { condition = in_mathzone }
  ),
}
return M, N
