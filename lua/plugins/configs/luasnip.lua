local M = {}

-- "/Users/samuelshowalter/Documents/Repos/Dotfiles/nvim/vim-plugins/"
-- vim.g.snipmate_snippets_path = DOT_ROOT .. "/vim-plugins/UltiSnips"
M.luasnip = function(opts)
  require("luasnip").config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

  -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

  -- snipmate format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
  -- print("Loaded everything")


  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end


-- ===========================================================
-- ADD SNIPPETS
-- ===========================================================

require("plugins.configs.snippets.tex_snippets")
require("plugins.configs.snippets.python_snippets")
require("plugins.configs.snippets.lua_snippets")
require("plugins.configs.snippets.markdown_snippets")
-- require("luasnip").filetype_extend("md", {"vimwiki"})

return M

