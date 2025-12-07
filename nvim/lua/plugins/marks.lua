return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  keys = {
    { "mm", desc = "Set next mark" },
    { "]m", desc = "Next mark" },
    { "[m", desc = "Previous mark" },
    { "m?", desc = "Preview mark" },
    { ";", mode = { "n", "x", "o" }, desc = "Repeat last move" },
    { ",", mode = { "n", "x", "o" }, desc = "Repeat last move opposite" },
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
  opts = {
    mappings = {
      set_next = "mm",
      next = false, -- disable default, will be set in config with repeatable move
      prev = false,
      preview = "m?",
    },
  },
  config = function(_, opts)
    require("marks").setup(opts)

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    local marks = require("marks")

    -- Setup repeatable moves using treesitter's repeatable_move
    local next_mark, prev_mark = ts_repeat_move.make_repeatable_move_pair(function()
      marks.next()
    end, function()
      marks.prev()
    end)

    vim.keymap.set({ "n", "x", "o" }, "]m", next_mark, { noremap = true, desc = "Next mark" })
    vim.keymap.set({ "n", "x", "o" }, "[m", prev_mark, { noremap = true, desc = "Previous mark" })
    vim.keymap.set(
      { "n", "x", "o" },
      ";",
      ts_repeat_move.repeat_last_move,
      { noremap = true, desc = "Repeat last move" }
    )
    vim.keymap.set(
      { "n", "x", "o" },
      ",",
      ts_repeat_move.repeat_last_move_opposite,
      { noremap = true, desc = "Repeat last move opposite" }
    )
  end,
}
