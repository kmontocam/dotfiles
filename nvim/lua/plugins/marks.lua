return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    mappings = {
      set_next = "mm",
      next = "]m",
      prev = "[m",
      preview = "m?",
    },
  },
  keys = {
    {
      "<leader>fm",
      function()
        -- default local nvim marks to exclude from the picker
        local excluded_marks = { '"', "'", ".", "[", "]", "^", "<", ">" }
        Snacks.picker.marks({
          global = false,
          ["local"] = true,
          filter = {
            cwd = true,
            filter = function(item)
              return not vim.tbl_contains(excluded_marks, item.label)
            end,
          },
        })
      end,
      desc = "Find Marks",
    },
  },
}
