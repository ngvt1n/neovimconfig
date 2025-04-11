local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local utils = require "snippets.functions"
local in_mathzone = utils.in_mathzone
local fs = function(_, snip)
  return snip.captures[1]
end
local fs2 = function(_, snip)
  return snip.captures[2]
end
local fsp = function(_, snip)
  print(vim.inspect(snip.captures))
  return snip.captures[1]
end

return {}, {
  -- expressions
  s(
    { trig = "([%a]);", regTrig = true, wordTrig = false },
    fmta("<>(<>)<>", { f(fs), i(1), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([|%]%}])(%w)", regTrig = true, wordTrig = false },
    fmta("<>_<>", { f(fs), f(fs2), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%a+)(%d)", regTrig = true, wordTrig = false },
    fmta("<>_<>", { f(fs), f(fs2), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([_|∥%w%)%]%}])'", regTrig = true, wordTrig = false },
    fmta("<>^", { f(fs), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([|∥%w%)%]%}])^(-%d)", regTrig = true, wordTrig = false },
    fmta("<>^{<>}<>", { f(fs), f(fs2), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%w+)%s*/%s*(%w+)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", { f(fsp), f(fs2), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "%((.+)%)%s*/%s*(%w+)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", {
      f(fsp),
      f(fs2),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%w+)%s*/%s*%((.+)%)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", { f(fsp), f(fs2), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "%((.+)%)%s*/%s*%((.+)%)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", { f(fsp), f(fs2), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "dint" },
    fmta("∫_{<>}^{<>} <> \\,dx<>", { i(1), i(2), i(3), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "int" },
    fmta("∫ <> \\,dx <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "iint" },
    fmta("∬_<> \\,dx <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "sum" },
    fmta("∑_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }
  ),
  s({ trig = "lim" }, fmta("\\lim_{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s(
    { trig = "ff" },
    fmta("{<> \\over <>} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
  s({ trig = "rr" }, fmta("\\sqrt{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s(
    { trig = "ss" }, fmta("_{<>}<>", { i(1), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])vv", regTrig = true, wordTrig = false },
    fmta("\\vec{<>}<>", { f(fs), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%w)x(%w)", regTrig = true, wordTrig = false },
    fmta("<> × <>", { f(fs), f(fs2), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "|||" },
    fmta("\\bigg|_{<>}^{<>} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
  -- symbols
  s({ trig = "set" }, fmta("\\{<>\\} <>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "co" }, fmta("[<>]_<>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "no" }, fmta("∥ <> ∥<>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "..." }, t "⋯ ", { condition = in_mathzone }), -- set
  s({ trig = "v..." }, t "⋮ "), -- vdots
  s({ trig = "d..." }, t "⋱ "), -- ddots
  s({ trig = "+-" }, t "\\pm", { condition = in_mathzone }),
  s({ trig = "<=" }, t "\\leqslant", { condition = in_mathzone }),
  s({ trig = ">=" }, t "\\geqslant", { condition = in_mathzone }),
  s({ trig = "==" }, t "\\approx", { condition = in_mathzone }),
  s({ trig = "->" }, t "→ ", { condition = in_mathzone }),
  s({ trig = "=>" }, t "⇒ ", { condition = in_mathzone }),
  s({ trig = "\\/ " }, t "⊥", { condition = in_mathzone }),
  s({ trig = "// " }, t "∥", { condition = in_mathzone }),
  s({ trig = "\\in" }, t "∈ ", { condition = in_mathzone }),
  s({ trig = "\\forall" }, t "∀ ", { condition = in_mathzone }),
  s({ trig = "\\notin" }, t "∉ ", { condition = in_mathzone }),
  s({ trig = ",,", wordTrig = false }, t "&", { condition = in_mathzone }),
  s({ trig = "inf" }, t "\\infty", { condition = in_mathzone }),
  s({ trig = "ee" }, fmta("e^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s({ trig = "*" }, t "⋅", { condition = in_mathzone }),
  s({ trig = "RR" }, t "\\RR", { condition = in_mathzone }),
  s({ trig = "BB", wordTrig = false }, t "𝔓 "),
  s({ trig = "UU", wordTrig = false }, t "𝔘 "),
  s({ trig = "tag" }, fmta("\\tag^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
}
