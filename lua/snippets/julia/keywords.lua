local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s("print", { t("print") }),
    s("return", { t("return") }),
}, {}
