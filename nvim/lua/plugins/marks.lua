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
          },
          transform = function(item, _)
            -- filter out default local marks
            if vim.tbl_contains(excluded_marks, item.label) then
              return false
            end
            return item -- keep marks set by user
          end,
        })
      end,
      desc = "Find Marks",
    },
  },
}
