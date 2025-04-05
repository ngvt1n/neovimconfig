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
local subscript = {
  ["0"] = "₀", ["1"] = "₁", ["2"] = "₂", ["3"] = "₃", ["4"] = "₄", 
  ["5"] = "₅", ["6"] = "₆", ["7"] = "₇", ["8"] = "₈", ["9"] = "₉",
}

return {}, {
  -- expressions
  s(
    { trig = "([%a]);", regTrig = true, wordTrig = false },
    fmta("<>(<>)<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%a%)%]%}])(%w)", regTrig = true, wordTrig = false },
    fmta("<><> ", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return subscript[snip.captures[2]] or "_" .. snip.captures[2]
      end),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])'(%w)", regTrig = true, wordTrig = false },
    fmta("<>^<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])'(-%d)", regTrig = true, wordTrig = false },
    fmta("<>^{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])ss", regTrig = true, wordTrig = false },
    fmta("<>_{<>} <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%w+)%s*/%s*(%w+)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", {
      f(function(_, snip)
        print(vim.inspect(snip.captures))
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "%((.+)%)%s*/%s*(%w+)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", {
      f(function(_, snip)
        print(vim.inspect(snip.captures))
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%w+)%s*/%s*%((.+)%)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", {
      f(function(_, snip)
        print(vim.inspect(snip.captures))
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "%((.+)%)%s*/%s*%((.+)%)%s", regTrig = true, wordTrig = false },
    fmta("\\frac{<>}{<>} <>", {
      f(function(_, snip)
        print(vim.inspect(snip.captures))
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "dint" },
    fmta("\\∫_{<>}^{<>} <> \\,dx <>", { i(1), i(2), i(3), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "int" },
    fmta("\\∫ <> \\,dx <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "iint" },
    fmta("\\∬_<> \\,dx <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "sum" },
    fmta("\\∑_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }
  ),
  s({ trig = "lim" }, fmta("\\lim_{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s(
    { trig = "ff" },
    fmta("\\frac{<>}{<>} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
  s({ trig = "rr" }, fmta("\\sqrt{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s(
    { trig = "([%w%)%]%}])vv", regTrig = true, wordTrig = false },
    fmta("\\vec{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%w)x(%w)", regTrig = true, wordTrig = false },
    fmta("<> × <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = in_mathzone }
  ),
  -- s(
  --   { trig = "(%((.*)%)|(%w))%/", regTrig=true, wordTrig=false },
  --   fmta("\\frac{<>}{<>} <>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     i(1),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    { trig = "|||" },
    fmta("\\bigg|_{<>}^{<>} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
  -- symbols
  s({ trig = "set" }, fmta("\\{<>\\} <>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "co" }, fmta("[<>]_<>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "..." }, t("⋯ "), { condition = in_mathzone }), -- set
  s({ trig = "v..." }, t("⋮ ")), -- vdots
  s({ trig = "d..." }, t("⋱ ")), -- ddots
  s({ trig = "+-" }, t "\\pm", { condition = in_mathzone }),
  s({ trig = "<=" }, t "\\leqslant", { condition = in_mathzone }),
  s({ trig = ">=" }, t "\\geqslant", { condition = in_mathzone }),
  s({ trig = "==" }, t "\\approx", { condition = in_mathzone }),
  s({ trig = "->" }, t "→ ", { condition = in_mathzone }),
  s({ trig = "=>" }, t "⇒ ", { condition = in_mathzone }),
  s({ trig = "ll" }, t "&", { condition = in_mathzone }),
  s({ trig = "inf" }, t "\\infty", { condition = in_mathzone }),
  s({ trig = "ee" }, fmta("e^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s({ trig = "*" }, t "⋅", { condition = in_mathzone }),
  s({ trig = "RR" }, t "\\RR", { condition = in_mathzone }),
  s({ trig = "BB" }, t "\\BB", { condition = in_mathzone }),
  s({ trig = "tag" }, fmta("\\tag^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
}
