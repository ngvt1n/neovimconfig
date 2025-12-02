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
local k = require("luasnip.nodes.key_indexer").new_key

local in_mathzone = utils.in_mathzone
local fs = function(_, snip)
  return snip.captures[1]
end
local fs2 = function(_, snip)
  return snip.captures[2]
end
-- local fsp = function(_, snip)
--   print(vim.inspect(snip.captures))
--   return snip.captures[1]
-- end
--

local function de(text, index) -- empty function_node
  local state = ""
  return f(function(args)
    -- local file = io.open("my_file.txt", "a")
    -- if file then
    --   file:write("arg" .. index .. ": " .. vim.inspect(args) .. "\n")
    --   file:write("state" .. index .. ": " .. vim.inspect(state or {}) .. "\n")
    -- end
    -- if file then
    --   file:close()
    -- end
    if state == "" and args[1][1] == "" then
      return text;
    elseif state ~= "" and args[1][1] ~= "" then
      return text;
    elseif state ~= "" and args[1][1] == "" then
      state = ""
      return "";
    elseif state == "" and args[1][1] ~= "" then
      state = args[1][1]
      return text;
    end
  end, { index })
end


return {
  s({ trig = "\\circ" }, t "∘ ", { show_condition = in_mathzone }), -- set
}, {
  -- expressions
  s(
    { trig = "([%a%}]);", regTrig = true, wordTrig = false },
    fmta("<>(<>)<>", { f(fs), i(1), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([|%]%}])(%w)", regTrig = true, wordTrig = false },
    fmta("<>_<>", { f(fs), f(fs2), }),
    { condition = in_mathzone }
  ),
  -- s(
  --   { trig = "(%u)(%l)", regTrig = true, wordTrig = false },
  --   fmta("<>_<>", { f(fs), f(fs2), }),
  --   { condition = in_mathzone }
  -- ),
  s(
    { trig = "(%a+)(%d)", regTrig = true, wordTrig = false },
    fmta("<>_<>", { f(fs), f(fs2), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%S)'", regTrig = true, wordTrig = false },
    fmta("<>^", { f(fs), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "(%S)^(-%d)", regTrig = true, wordTrig = false },
    fmta("<>^{<>}<>", { f(fs), f(fs2), i(0), }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "dint" }, {
      t "∫",
      sn(1, { t("_{"), i(1), t("}") }),
      sn(2, { t("^{"), i(1), t("} ") }),
      i(3), t "\\,dx",
      i(0)
    },
    { condition = in_mathzone }
  ),
  s(
    { trig = "int" },
    fmta("∫ <> \\,dx <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "iint" },
    fmta("∬_<> \\,dA <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "iiint" },
    fmta("∭_<> \\,dV <>", { i(1), i(0) }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "oint" },
    fmta("∮_{<>} <> ⋅ d\\vec{r} <>", { i(1), i(2), i(0) }),
    { condition = in_mathzone }
  ),
    s(
      { trig = "oiint" },
      fmta("∯_{<>} <> ⋅ d\\vec{S} <>", { i(1), i(2), i(0) }),
      { condition = in_mathzone }
    ),
  s(
    { trig = "sum" },
    fmta("∑_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }
  ),
  s(
    { trig = "\\U" },
    fmta("⋃_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }
  ),
  s(
    { trig = "-\\U" },
    fmta("⋂_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }
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
    { trig = "([%w%)%]%}])_-vv", regTrig = true, wordTrig = false },
    fmta("\\vec{<>}<>", { f(fs), i(0), }),
    { condition = in_mathzone }
  ),
  s("cccm", {
    t { '\\mq ', '' },
    l(l._1:gsub("[^&]", " "):gsub("  &", "| &") .. "|", { 1 }), t { '\\\\', '' },
    i(1), t { '    \\\\', '' },
    l(l._1:gsub("[^&]", " "):gsub("  &", "| &") .. "|", { 1 }),
    t { '', '\\md' },
    i(0)
  }),
  -- symbols
  s("ang", t("∠ "), { condition = in_mathzone }),
  s({ trig = "set" }, fmta("\\{<>\\}<>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "c=" }, t "⊂", { condition = in_mathzone }), -- set
  s({ trig = "c/=" }, t "\\not⊂", { condition = in_mathzone }), -- set
  -- s({ trig = "co" }, fmta("[<>]_<>", { i(1), i(0) }), { condition = in_mathzone }), -- set
  s({ trig = "..." }, t "⋯ ", { condition = in_mathzone }), -- set
  s({ trig = "v..." }, t "⋮ "), -- vdots
  s({ trig = "d..." }, t "⋱ "), -- ddots
  s({ trig = "\\times" }, t "×"),
  s({ trig = "+-" }, t "±"),
  s({ trig = "-+" }, t "∓"),
  s({ trig = "<=" }, t "≤", { condition = in_mathzone }),
  s({ trig = ">=" }, t "≥", { condition = in_mathzone }),
  s({ trig = "~=" }, t "\\approx", { condition = in_mathzone }),
  s({ trig = "!=" }, t "\\not =", { condition = in_mathzone }),
  s({ trig = "->" }, t "→ ", { condition = in_mathzone }),
  s({ trig = "=>" }, t "⇒ ", { condition = in_mathzone }),
  s({ trig = "\\maps" }, t "↦ ", { condition = in_mathzone }),
  s({ trig = "\\/" }, t "⊥", { condition = in_mathzone }),
  s({ trig = "||" }, t "∥", { condition = in_mathzone }),
  s({ trig = "\\in" }, t "∈ ", { condition = in_mathzone }),
  s({ trig = "\\ni" }, t "∉ ", { condition = in_mathzone }),
  s({ trig = "\\qed" }, t "\\quad □", { condition = in_mathzone }),
  s({ trig = "\\forall", wordTrig = false }, t "∀ ", { condition = in_mathzone }),
  s({ trig = "\\exists", wordTrig = false }, t "∃ ", { condition = in_mathzone }),
  s({ trig = ",,", wordTrig = false }, t "&", { condition = in_mathzone }),
  s({ trig = "inf" }, t "∞", { condition = in_mathzone }),
  s({ trig = "ee" }, fmta("e^{<>} <>", { i(1), i(0) }), { condition = in_mathzone }),
  s({ trig = "*" }, t "⋅", { condition = in_mathzone }),
  s({ trig = "RR" }, t "\\RR", { condition = in_mathzone }),
  s({ trig = "NN" }, t "\\NN", { condition = in_mathzone }),
  s({ trig = "\\NN*" }, t "\\NN^*", { condition = in_mathzone }),
  s({ trig = "ZZ" }, t "\\ZZ", { condition = in_mathzone }),
  s({ trig = "BB", wordTrig = false }, t "𝔓 "),
  s({ trig = "UU", wordTrig = false }, t "𝔘 "),
  s({ trig = "\\big|" }, fmta("\\big|_{<>}^{<>} <>", { i(1), i(2), i(0) }), { condition = in_mathzone }),
  s({ trig = "cos" }, t "\\cos", { condition = in_mathzone }),
  s({ trig = "sin" }, t "\\sin", { condition = in_mathzone }),
  s({ trig = "\\contra" }, t "\\quad ↯", { condition = in_mathzone }),
  s({ trig = "\\del" }, t "∇ ", { condition = in_mathzone }),
  s({ trig = "??" }, fmta("\\overset{?}{<>}<>", {i(1), i(0)}), { condition = in_mathzone }),
}
