-- ===========================================================
-- CONFIGURATION
-- ===========================================================

-- Set up backend for vimtex 
vim.g.vimtex_view_method = 'skim' 
-- let g:vimtex_quickfix = 0
vim.g.vimtex_quickfix_bibtex = {'enabled': 1}
vim.g.vimtex_mappings_enabled = 1
vim.opt.conceallevel=1
vim.g.tex_conceal='abdmg'
vim.g.tex_flavor = 'xelatex'
vim.g.Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'
vim.g.Tex_MultipleCompileFormats='pdf,bibtex,pdf'
vim.g.vimtex_quickfix_ignore_filters = {
  'Underfull',
  'Overfull',
  'I found',
  'Empty',
  'specifier changed to',
  'You have requested',
  'Missing number, treated as zero.',
  'There were undefined references',
  'Citation %.%# undefined',
  'Double space found',
}

-- Vimtex warnings ignore
vim.g.vimtex_quickfix_open_on_warning = 0

