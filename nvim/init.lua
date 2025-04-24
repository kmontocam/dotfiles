---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end

require("kmontocam.core.keymaps")
require("kmontocam.core.options")
require("kmontocam.lazy")

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = {
    current_line = true,
  },
})
