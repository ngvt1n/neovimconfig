local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "snippets.functions"
local l = require "luasnip.extras".lambda
local in_mathzone = utils.in_mathzone

return {
  s("aq", t "(aq)"),
  s("solid", t "(s)"),
  s("gas", t "(g)")
}, {
  s({ trig = "\\L" }, t "\\, L", { condition = in_mathzone }),
  s({ trig = "mL" }, t "\\, mL", { condition = in_mathzone }),
  s({ trig = "mol" }, t "\\, mol", { condition = in_mathzone }),
  s({ trig = "\\M" }, t "\\, M", { condition = in_mathzone }),
  s({ trig = "Kb" }, t "K_b", { condition = in_mathzone }),
  s({ trig = "Ka" }, t "K_a", { condition = in_mathzone }),
  -- s({ trig = "\\fw" }, t "⇌  ", { condition = in_mathzone }),
  -- s("^+", t "⁺"),
  -- s("^-", t "₋"),
  s("\\ce", {t"\\ce{", i(1), t"}", i(0)}),
}
