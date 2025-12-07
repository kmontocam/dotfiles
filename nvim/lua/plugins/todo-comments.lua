return {
  "folke/todo-comments.nvim",
  lazy = true,
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next TODO comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous TODO comment",
    },
    {
      "<leader>ft",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } })
      end,
      desc = "Find TODO/FIX",
    },
  },
  opts = {},
}
