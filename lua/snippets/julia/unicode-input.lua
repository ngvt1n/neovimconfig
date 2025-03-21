local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	-- greek
	s("\\a", { t("α") }),
	s("\\b", { t("β") }),
	s("\\g", { t("γ") }),
	-- operators
	s("\\div", { t("÷") }), -- Integer division
	s("\\xor", { t("⊻") }), -- Exclusive or
	s("\\pm", { t("±") }), -- Plus-minus sign
	s("\\composite", { t("∘") }), -- Function composition
	s("\\sqrt", { t("√") }), -- Square root
	s("\\cbrt", { t("∛") }), -- Cube root
	s("\\cap", { t("∩") }), -- Set intersection
	s("\\cup", { t("∪") }), -- Set union
	s("\\notin", { t("∉") }), -- Not element of
	s("\\subseteq", { t("⊆") }), -- Subset equal
	s("\\subset", { t("⊂") }), -- Strict subset
	s("\\ne", { t("≠") }), -- Not equal to
	s("\\approx", { t("≈") }), -- Approximately equal to
}, {
	s("<=", { t("≤") }), -- Less than or equal to
	s(">=", { t("≥") }), -- Greater than or equal to
	s("\\in", { t("∈") }), -- Element of
}
