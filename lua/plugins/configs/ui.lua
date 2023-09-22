local highlights = require "custom.highlights"

local options = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = {
    Comment = {
      italic = true,
    },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  }
}

return options
