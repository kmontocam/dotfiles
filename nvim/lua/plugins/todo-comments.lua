---@diagnostic disable: undefined-field
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  depedenencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    vim.keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next TODO comment" })

    vim.keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous TODO comment" })

    todo_comments.setup()
  end,
  keys = {
    {
      "<leader>ft",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } })
      end,
      desc = "Find TODO/FIX",
    },
  },
}
