return {
  "Mofiqul/vscode.nvim",
  priority = 1000,
  config = function()
    local vscode = require("vscode")
    local c = require("vscode.colors").get_colors()
    vscode.setup({
      -- Alternatively set style in setup
      -- style = 'light'

      -- Enable transparent background
      -- transparent = true,

      -- Enable italic comment
      italic_comments = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        vscLineNumber = "#858585",
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      },
    })
    vim.cmd([[colorscheme vscode]])
  end,
}
