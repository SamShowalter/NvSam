
-- ===========================================================
-- CONFIGURATION
-- ===========================================================

-- let g:gutentags_add_default_project_roots = 0
vim.g.gutentags_project_root = {'package.json', '.git'}

-- Clear Gutentag Cache quickly
-- command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

-- Cache ctags
local home = os.getenv("HOME")
vim.g.gutentags_cache_dir = home .. '/.cache/vim/ctags/'

-- When to generate tags
vim.g.gutentags_generate_on_new = 1
vim.g.gutentags_generate_on_missing = 1
vim.g.gutentags_generate_on_write = 1
vim.g.gutentags_generate_on_empty_buffer = 0

-- Gutentags information exclude
vim.g.gutentags_ctags_exclude = {
      '*.git', '*.svg', '*.hg',
      '*/tests/*',
      'build',
      'dist',
      '*sites/*/files/*',
      'bin',
      'node_modules',
      'bower_components',
      'cache',
      'compiled',
      'docs',
      'example',
      'bundle',
      'vendor',
      '*.md',
      '*-lock.json',
      '*.lock',
      '*bundle*.js',
      '*build*.js',
      '.*rc*',
      '*.json',
      '*.min.*',
      '*.map',
      '*.bak',
      '*.zip',
      '*.pyc',
      '*.class',
      '*.sln',
      '*.Master',
      '*.csproj',
      '*.tmp',
      '*.csproj.user',
      '*.cache',
      '*.pdb',
      'tags*',
      'cscope.*',
      '*.css',
      '*.less',
      '*.scss',
      '*.exe', '*.dll',
      '*.mp3', '*.ogg', '*.flac',
      '*.swp', '*.swo',
      '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      'ipynb_checkpoints/*','*.ipynb', "*.wiki",
}
