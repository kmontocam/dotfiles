return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "[g",
      function()
        ---@diagnostic disable-next-line: param-type-mismatch
        require("gitsigns").nav_hunk("prev")
      end,
      desc = "Git Previous Hunk",
    },
    {
      "]g",
      function()
        ---@diagnostic disable-next-line: param-type-mismatch
        require("gitsigns").nav_hunk("next")
      end,
      desc = "Git Next Hunk",
    },
    {
      "<leader>gb",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gB",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Git Toggle Line Blame",
    },
  },
}
