return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = require("gitsigns")

      vim.keymap.set("n", "[g", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        gs.nav_hunk("prev")
      end, { buffer = bufnr, desc = "Git Previous Hunk" })
      vim.keymap.set("n", "]g", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        gs.nav_hunk("next")
      end, { buffer = bufnr, desc = "Git Next Hunk" })

      vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, { buffer = bufnr, desc = "Git Blame Line" })

      vim.keymap.set("n", "<leader>gB", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Git Toggle Line Blame" })
    end,
  },
}
