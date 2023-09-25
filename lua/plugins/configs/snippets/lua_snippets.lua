
local ls = require("luasnip")

-- ===========================================================
-- CREATE SNIPPETS
-- ===========================================================

local com_snip = ls.parser.parse_snippet({ trig = "com", name = "Block Comment" },
[[-- ===========================================================
-- $1
-- ===========================================================
$0
]])

-- ===========================================================
-- ADD SNIPPETS
-- ===========================================================

ls.add_snippets("lua",
  {com_snip}
)
