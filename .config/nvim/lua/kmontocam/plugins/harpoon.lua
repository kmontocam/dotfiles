return {
  "theprimeagen/harpoon",
  config = function()
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    vim.keymap.set("n", "<leader>a", function()
      mark.add_file()
    end, { desc = "Mark file with Harpoon" })

    vim.keymap.set("n", "<leader>hh", function()
      ui.toggle_quick_menu()
    end, { desc = "Toggle Harpoon Quick Menu" })

    vim.keymap.set("n", "<C-B>", function()
      ui.nav_prev()
    end, { desc = "Go to previous harpoon mark" })

    vim.keymap.set("n", "<C-N>", function()
      ui.nav_next()
    end, { desc = "Go to next harpoon mark" })
  end,
}
