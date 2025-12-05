return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>fm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Find Marks",
    },
  },
}
