local ls = require("luasnip")
local s = ls.extend_decorator.apply(ls.snippet, decorator) --[[@as function]]
local utils = require("luasnip-latex-snippets.util.utils")

-- ===========================================================
-- CREATE SNIPPETS
-- ===========================================================


local dk_snip = ls.parser.parse_snippet({ trig = "dk", name = "Math" }, "$${1:${TM_SELECTED_TEXT}}$$0")
local superscript_snip = ls.parser.parse_snippet({ trig = "tk", regTrig = true, condition = utils.is_math, wordTrig=false, name = "Exponentiate" },"^{$1}$0")
local sum_snip = ls.parser.parse_snippet({ trig = "sum", regTrig = true, condition = utils.is_math, wordTrig=false, name = "Automatic sum" },"\\sum^{${1:n}}_{${2:i=1}}{0}$")
local cref_snip = ls.parser.parse_snippet({ trig = "cref", regTrig = true, wordTrig=false, name = "C reference" },"\\Cref{$1}$0")
local min_snip = ls.parser.parse_snippet({ trig = "([^\\,arg,i])min$", regTrig = true, condition = utils.is_math, wordTrig=false, name = "minimum" },"\\min$0")

-- local mcal_snip = ls.parser.parse_snippet({
--   s(
--       {
--         trig = "(%a)mcal",
--         wordTrig = false,
--         regTrig = true,
--         name = "bar",
--         priority = 100,
--       },
--       f(function(_, snip)
--         return string.format("\\overline{%s}", snip.captures[1])
--       end, {})
--     ),
-- })

-- ===========================================================
-- ADD SNIPPETS TO CONFIG
-- ===========================================================

ls.add_snippets("tex",
  {dk_snip, superscript_snip, cref_snip, sum_snip, min_snip},
  {type = "autosnippets", priority=250}
)
