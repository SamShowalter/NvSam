-- n, v, i, t = mode names 
local M = {}
local silent = {silent=true}
local var_noremap = {noremap=true}
local var_noremap_silent = {silent=true, noremap=true}


M.general = {
  i = {
    -- go to  beginning and end
    -- ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    -- ["<C-e>"] = { "<End>", "End of line" },

    -- -- navigate within insert mode
    -- ["<C-h>"] = { "<Left>", "Move left" },
    -- ["<C-l>"] = { "<Right>", "Move right" },
    -- ["<C-j>"] = { "<Down>", "Move down" },
    -- ["<C-k>"] = { "<Up>", "Move up" }, 
  },

  n = {

    -- Directory change information
    -- " Change current working directory to the current file 
    -- map <Leader>cd :cd %:p:h<CR>:pwd<CR>
    --
    -- " Move up a directory
    -- nnoremap <Leader>ud :cd ..<CR>

    -- Quickly access important files
    -- ["<leader>vi"] = {":e $DOT_ROOT/../init.lua<CR>", "Quickly access the .vimrc file"},
    ["<leader>zi"] = {":e $DOT_ROOT/../.zshrc<CR>", "Quickly access the .zshrc file"},
    ["<leader>lp"] = {":e $DOT_ROOT/../.pylintrc<CR>:145<CR>", "Quickly access the .pylintrc file"},

    -- Compile code
    ["<leader>cp"] = {":call CompileAll() <CR><C-h>", "Compile all code in file"},

    -- Better copy and pasting (leader neeeds to not be remapped)
    ["<leader>d"] = {"d", "Copying content with standard d", var_noremap},
    ["d"] = {'"_d', "Delete content with black hole register", var_noremap},
    ["D"] = {'"_D', "Delete content with black hole register", var_noremap},
    ["x"] = {'"_x', "Delete letter with black hole register", var_noremap},
    ["c"] = {'"_c', "Change content with black hole register", var_noremap},

    -- Copy filepaths
    ["<Leader>pc"] = {"let @+=expand('%:t')<CR>", "Copy filepath to use later"},

    -- Easy Quitting
    ["<leader>qq"] = {":qa!<CR>", "Quickly close out of all files", var_noremap},

    -- Tab text over quickly
    [">"] = {">>", "Quickly tab text right", var_noremap},
    ["<"] = {"<<", "Quickly tab text left", var_noremap},

    --Clear highlighting
    ["<leader><CR>"] = { ":noh <CR>", "Clear highlights", var_noremap_silent},

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" , var_noremap},
    ["<C-l>"] = { "<C-w>l", "Window right", var_noremap },
    ["<C-j>"] = { "<C-w>j", "Window down", var_noremap},
    ["<C-k>"] = { "<C-w>k", "Window up" , var_noremap},

    -- Close files to right and left
    -- "<C-w>l :bd<CR>"
    ["<Leader>op"] = {
      function()
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<C-w>l", true, false, true),
          "n", false)
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes(":bd!<CR>", true, false, true),
          "n", false)
      end, "Close right vertical pane", silent},
    -- ["<Leader>oo"] = {":bd<CR>", "Close right vertical pane"},
    -- ["<Leader>op"] = {"<leader>1p <leader>1o", "Close left vertical pane"},
    ["<Leader>po"] = {"<C-w>h <cmd> bd! <CR>", "Close left vertical pane", silent},

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    -- ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {

    -- Better copy and pasting (leader neeeds to not be remapped)
    ["<leader>d"] = {"d", "Copying content with standard d", var_noremap},
    ["d"] = {'"_d', "Delete content with black hole register", var_noremap},
    ["D"] = {'"_D', "Delete content with black hole register", var_noremap},
    ["x"] = {'"_x', "Delete letter with black hole register", var_noremap},
    ["c"] = {'"_c', "Change content with black hole register", var_noremap},

    -- visual shifting of blocks for easier use 
    ["J"] = {":m '>1<CR>gv=gv", "Visual shifting of lines up", var_noremap},
    ["K"] = {":m '<-2<CR>gv=gv", "Visual shifting of lines down", var_noremap},
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "De-Indent line" },
    [">"] = { ">gv", "Indent line" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<leader>r"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<leader>e"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>s"] = {
      function()
        require("nvchad.tabufline").close_buffer()
        require("nvchad.tabufline").tabuflinePrev() -- Make it more like I am used to
      end,
      "Close buffer",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    -- ["<leader>ra"] = {
    --   function()
    --     require("nvchad.renamer").open()
    --   end,
    --   "LSP rename",
    -- },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    -- ["<leader>f"] = {
    --   function()
    --     vim.diagnostic.open_float { border = "rounded" }
    --   end,
    --   "Floating diagnostic",
    -- },
    --
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "Diagnostic setloclist",
    -- },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>jf"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    -- ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>ft"] = { "<cmd> Telescope lsp_document_symbols symbols=module,class,function,method <CR>", "Find Tags" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fw"] = { "<cmd> Telescope find_files search_dirs={'" .. WIKI_DIR .. "'} <CR>", "Find Vim Wiki Files" },
    -- ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
    -- ["<C-j>"] = {require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse, "Toggle results down"},
    -- ["<C-k>"] = {require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better, "Toggle results up"},
  },
}

M.leap = {
  plugin = true,

  n = {
    ["<leader>lj"] = {"<cmd>lua leap_to_line_forward()<CR>", "Leap to specific line down"},
    ["<leader>lk"] = {"<cmd>lua leap_to_line_backwards()<CR>", "Leap to specific line up"},
  },
  v = {
    ["<leader>lj"] = {"<cmd>lua leap_to_line_forward()<CR>", "Leap to specific line down"},
    ["<leader>lk"] = {"<cmd>lua leap_to_line_backwards()<CR>", "Leap to specific line up"},
  }
}

M.nvterm = {
  plugin = true,

  t = {

    ["<leader>nt"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {

    ["<leader>nt"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wk"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },

  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- -- Actions
    -- ["<leader>rh"] = {
    --   function()
    --     require("gitsigns").reset_hunk()
    --   end,
    --   "Reset hunk",
    -- },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

return M
