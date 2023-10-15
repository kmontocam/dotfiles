return {
  "theprimeagen/harpoon",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>h",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      { desc = "Toggle Harpoon Quick Menu" }
    )
    vim.keymap.set(
      "n",
      "<leader>a",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      { desc = "Mark file with Harpoon" }
    )
    vim.keymap.set(
      "n",
      "<C-B>",
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      { desc = "Go to previous harpoon mark" }
    )
    vim.keymap.set(
      "n",
      "<C-N>",
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      { desc = "Go to next harpoon mark" }
    )
  end,
}
