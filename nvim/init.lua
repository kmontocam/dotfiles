---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end

require("core.keymaps")
require("core.options")
require("lazy")

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = {
    current_line = true,
  },
})
