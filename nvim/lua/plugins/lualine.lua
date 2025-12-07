return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local lazy_status = require("lazy.status")

    return {
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          "encoding",
          { "fileformat", symbols = { unix = "" } },
          "filetype",
        },
      },
      options = {
        theme = "vscode",
      },
      extensions = { "nvim-tree" },
    }
  end,
}
