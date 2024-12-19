return {
  "stevearc/oil.nvim",
  event = { "VimEnter */*,.*", "BufNew */*,.*" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      mode = "n",
      "<leader>e",
      "<cmd>Oil<CR>",
      desc = "Open the Oil file viewer",
    },
  },
  opts = {
    delete_to_trash = true,
    keymaps = {
      ["<leader>e"] = { "actions.close", mode = "n" },
    },
    view_options = {
      show_hidden = true,
    },
  },
}
