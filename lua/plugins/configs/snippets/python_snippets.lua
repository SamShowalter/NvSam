local ls = require("luasnip")

-- ===========================================================
-- CREATE SNIPPETS
-- ===========================================================

local template_snip = ls.parser.parse_snippet({ trig = "template", name = "Python Template" },
[[#################################################################################
#
#             Project Title:  ${1:TITLE}              Class: ${2:CLASS}
#             Author:         ${3:AUTHOR}
#             Date:           ${4:DATE}
#
#################################################################################


#################################################################################
#   Module Imports
#################################################################################

${5:}

#################################################################################
#   Function-Class Declaration
#################################################################################

${6:}

#################################################################################
#   Main Method
#################################################################################

${7:} 

]]
)

local com_snip = ls.parser.parse_snippet({ trig = "com", name = "Section comment" },
  [[#######################################################################
# $1
#######################################################################
$0 
]]
)

local print_snip = ls.parser.parse_snippet({ trig = "p", name = "Print statement" }, "print($1)$0")
local sxx_snip = ls.parser.parse_snippet({ trig = "sxx", name = "Add breakpoint" }, "sys.exit(1)$0")
local bc_snip = ls.parser.parse_snippet({ trig = "bc", name = "Block comment" }, '"""\n$1"""\n$0')


-- ===========================================================
-- ADD SNIPPETS TO CONFIG
-- ===========================================================

ls.add_snippets("python",
  {template_snip, com_snip, print_snip, bc_snip}
)

ls.add_snippets("python",
  {sxx_snip},
  {type="autosnippets"}
)
