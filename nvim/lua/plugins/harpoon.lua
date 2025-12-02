return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Mark file with Harpoon" })

    vim.keymap.set("n", "<leader>ha", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle Harpoon Quick Menu" })

    vim.keymap.set("n", "<C-B>", function()
      harpoon:list():prev()
    end, { desc = "Go to previous harpoon mark" })

    vim.keymap.set("n", "<C-N>", function()
      harpoon:list():next()
    end, { desc = "Go to next harpoon mark" })
  end,
}
