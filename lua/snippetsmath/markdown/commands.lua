local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
local utils = require "snippets.functions"
-- local get_visual = utils.get_visual
local in_mathzone = utils.in_mathzone
-- local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s("exists",
    t("\\exists"),
    { condition = in_mathzone }
  ),
  s("ang",
    t("∠ "),
    { condition = in_mathzone }
  ),
}, {
  s("and ",
    t("\\text{ and }"),
    { condition = in_mathzone }
  ),
  s("in ",
    t("∈ "),
    { condition = in_mathzone }
  ),
  s("notin ",
    t("∉ "),
    { condition = in_mathzone }
  ),
}
