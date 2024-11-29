return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")
    vim.g.loaded = 1
    vim.g.loaded_netrwPlugini = 1

    nvimtree.setup({
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      view = {
        width = 32,
        relativenumber = true,
      },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
  end,
}
