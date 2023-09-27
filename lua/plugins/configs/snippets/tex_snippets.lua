local ls = require("luasnip")
local s = ls.extend_decorator.apply(ls.snippet, decorator) --[[@as function]]
local utils = require("luasnip-latex-snippets.util.utils")

-- ===========================================================
-- VARIABLES FUNCTIONS
-- ===========================================================

-- Different banned chars
local char_dict = {
  sim = {"\\"}, lim = {"\\"}, forall = {"\\"}, subset = {"\\"},
  inf = {"\\"}, text = {"\\"}, rightarrow = {"\\"}, mcal = {"\\"},
  leq = {"\\"}, geq = {"\\"}, ll = {"\\"}, inn = {"\\", "not",}, notin = {"\\"},
  bf = {"text", "math"}, tl = {"%w+"}, bb = {"math"}, msc = {"math"},
  min = {"\\", "arg","i"}, max = {"\\", "arg","i"},
  set = {"\\","under","over"},
}

-- ===========================================================
-- HELPER FUNCTIONS
-- ===========================================================

-- Helper function contains value
local function contains_value (tab, val)
    for index, value in ipairs(tab) do
        -- We grab the first index of our sub-table instead
        if string.find(val,value, 0, true) then
            return true
        end
    end

    return false
end


-- ===========================================================
-- CONDITION FUNCTION
-- ===========================================================

-- regex condition
local latex_regex_not_math_cond_function = function(line_to_cursor, matched_trigger, captures)
  -- return true
  local not_inside_math = utils.not_math(line_to_cursor, matched_trigger, captures)
  local word = line_to_cursor:reverse():match("%S+"):reverse():gsub("min","")
  return (not contains_value(char_dict[matched_trigger],word)) and not_inside_math
end

-- regex condition
local latex_regex_math_cond_function = function(line_to_cursor, matched_trigger, captures)
  -- return true
  local inside_math = utils.is_math(line_to_cursor, matched_trigger, captures)
  local word = line_to_cursor:reverse():match("%S+"):reverse():gsub("min","")
  return (not contains_value(char_dict[matched_trigger],word)) and inside_math
end

-- regex condition
local greek_cond_function = function(line_to_cursor, matched_trigger, captures)
  -- return true
  local banned_chars = {"\\", "%w+"} --Can't already be created or have any non-whitespace
  local not_inside_math = utils.not_math(line_to_cursor, matched_trigger, captures)
  local word = line_to_cursor:reverse():match("%S+"):reverse():gsub("min","")
  return (not contains_value(banned_chars,word)) and not_inside_math
end

-- ===========================================================
-- CREATE SNIPPETS (NOT AUTO)
-- ===========================================================

local lab_snip = ls.parser.parse_snippet({ trig = "l", name = "Label" },"\\label{$1}")
local ref_snip = ls.parser.parse_snippet({ trig = "r", name = "Label" },"\\ref{$1}$0")
local com_snip = ls.parser.parse_snippet({ trig = "com", name = "Block Comment" },
  [[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$0]])

local lc_snip = ls.parser.parse_snippet({ trig = "lc", name = "Line Comment" },
  [[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$0]])

-- ===========================================================
-- AUTO SNIPPETS
-- ===========================================================

local dk_snip = ls.parser.parse_snippet({ trig = "dk", condition = utils.not_math, name = "Math" }, "$${1:${TM_SELECTED_TEXT}}$$0")
local superscript_snip = ls.parser.parse_snippet({ trig = "tk", condition = utils.is_math, wordTrig=false,  name = "Exponentiate" },"^{$1}$0")
local sum_snip = ls.parser.parse_snippet({ trig = "sum", condition = utils.is_math, wordTrig=false, name = "Automatic sum" },"\\sum^{${1:n}}_{${2:i=1}}$0")
local cref_snip = ls.parser.parse_snippet({ trig = "cref", name = "C reference" },"\\Cref{$1}$0")
local vsp_snip = ls.parser.parse_snippet({ trig = "vsp", name = "Vertical space" },"\\vspace{$1pt}$0")

-- ===========================================================
-- GREEK LETTERS
-- ===========================================================
local greeks = {}
local greek_lower= "alpha beta chi delta epsilon gamma iota kappa lambda omega phi rho sigma tau theta zeta"
local greek_upper= "Alpha Beta Chi Delta Epsilon Gamma Iota Kappa Lambda Mu Nu Omega Phi Pi Rho Sigma Tau Theta Zeta Eta"

-- Add greek lower
for lower_g in greek_lower:gmatch("%S+") do
  greeks[#greeks + 1] = ls.parser.parse_snippet({ trig = lower_g,
  condition = greek_cond_function,
  name = lower_g },"$\\" .. lower_g .. "$$0")
end

-- Add greek upper
for upper_g in greek_upper:gmatch("%S+") do
  greeks[#greeks + 1] = ls.parser.parse_snippet({ trig = upper_g,
  condition = greek_cond_function,
  name = upper_g },"$\\" .. upper_g .. "$$0")
end

print(#greeks)

-- ===========================================================
-- REGEX CONDITION SNIPPETS
-- ===========================================================
local min_snip = ls.parser.parse_snippet({ trig = "min",
  condition = latex_regex_math_cond_function,
  wordTrig=false, name = "minimum" },"\\min$0")
local max_snip = ls.parser.parse_snippet({ trig = "max",
  condition = latex_regex_math_cond_function,
  name = "maximum" },"\\max$0")
local sim_snip = ls.parser.parse_snippet({ trig = "sim",
  condition = latex_regex_math_cond_function,
  name = "Similar to" },"\\sim$0")
local inf_snip = ls.parser.parse_snippet({ trig = "inf",
  condition = latex_regex_math_cond_function,
  name = "infinity" },"\\infty$0")
local lim_snip = ls.parser.parse_snippet({ trig = "lim",
  condition = latex_regex_math_cond_function,
  name = "limit" },"\\lim_{${1:n} \\to ${2:\\infty}}$0")
local forall_snip = ls.parser.parse_snippet({ trig = "forall",
  condition = latex_regex_math_cond_function,
  name = "For all" },"\\forall$0")
local subset_snip = ls.parser.parse_snippet({ trig = "subset",
  condition = latex_regex_math_cond_function,
  name = "Subset" },"\\subet$0")
local rightarrow_snip = ls.parser.parse_snippet({ trig = "rightarrow",
  condition = latex_regex_math_cond_function,
  name = "right arrow" },"\\rightarrow$0")
local mcal_snip_simple = ls.parser.parse_snippet({ trig = "mcal",
  condition = latex_regex_math_cond_function,
  name = "Math Cal" },"\\mathcal{$1}$0")
local geq_snip = ls.parser.parse_snippet({ trig = "geq",
  condition = latex_regex_math_cond_function,
  name = "Greater than or equal to" },"\\geq$0")
local leq_snip = ls.parser.parse_snippet({ trig = "leq",
  condition = latex_regex_math_cond_function,
  name = "Less than or equal to" },"\\geq$0")
local ll_snip = ls.parser.parse_snippet({ trig = "ll",
  condition = latex_regex_math_cond_function,
  name = "Much less than or equal to" },"\\ll$0")
local notin_snip = ls.parser.parse_snippet({ trig = "ll",
  condition = latex_regex_math_cond_function,
  name = "Not in" },"\\notin$0")
local in_snip = ls.parser.parse_snippet({ trig = "inn",
  condition = latex_regex_math_cond_function,
  name = "In" },"\\in$0")
local text_snip = ls.parser.parse_snippet({ trig = "text",
  condition = latex_regex_math_cond_function,
  name = "Text snippet" },"\\text{$1}$0")
local set_snip = ls.parser.parse_snippet({ trig = "set",
  condition = latex_regex_math_cond_function,
  name = "set" },"\\{$1\\}$0")
local bb_snip = ls.parser.parse_snippet({ trig = "bb",
  condition = latex_regex_math_cond_function,
  name = "Math bb font" },"\\mathbb{$1}$0")
local scr_snip = ls.parser.parse_snippet({ trig = "msc",
  condition = latex_regex_math_cond_function,
  name = "Math script font" },"\\mathscr{$1}$0")
local bf_math_snip = ls.parser.parse_snippet({ trig = "bf",
  condition = latex_regex_math_cond_function,
  name = "Bold font" },"\\mathbf{$1}$0")
local bf_snip = ls.parser.parse_snippet({ trig = "bf",
  condition = latex_regex_not_math_cond_function,
  name = "Bold font" },"\\textbf{$1}$0")
local tl_snip = ls.parser.parse_snippet({ trig = "tl",
  condition = latex_regex_not_math_cond_function,
  name = "Italics" },"\\textit{$1}$0")

-- ===========================================================
-- ADD SNIPPETS TO CONFIG (NOT AUTO)
-- ===========================================================

-- Add non-auto snippets
ls.add_snippets("tex",
  {
    com_snip, lc_snip,
    lab_snip, ref_snip,
  },
  {priority=250}
)

-- ===========================================================
-- ADD SNIPPETS TO CONFIG (AUTO)
-- ===========================================================

-- Add greek letters
ls.add_snippets("tex",
  greeks,
  {type = "autosnippets", priority=250}
)

-- Add other snippets
ls.add_snippets("tex",
  {
    dk_snip, superscript_snip, cref_snip, sum_snip,
    min_snip, max_snip, set_snip,  vsp_snip,
    text_snip, mcal_snip_simple, rightarrow_snip, subset_snip,
    sim_snip, forall_snip, inf_snip, lim_snip,
    geq_snip, leq_snip, ll_snip, in_snip, notin_snip,
    bf_snip, tl_snip, bf_math_snip, bb_snip, scr_snip,
  },
  {type = "autosnippets", priority=250}
)
