-- ===========================================================
-- CONFIGURATION
-- ===========================================================

-- Set up where the wiki lists should be
let g:vimwiki_list = {{path = WIKI_DIR,
                       syntax = 'markdown', 
                       ext = '.md'}}

-- Ensures that not all markdown files are considered wiki files
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_table_mappings=0

