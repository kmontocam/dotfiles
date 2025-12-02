return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/debugpy"

      require("dap-python").setup(debugpy_path)
      require("dapui").setup()
      ---@diagnostic disable-next-line: missing-parameter
      require("nvim-dap-virtual-text").setup()

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dr", dap.run_to_cursor)

      vim.keymap.set("n", "<leader>?", function()
        ---@diagnostic disable-next-line: missing-fields
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "DAP Step Out" })
      vim.keymap.set("n", "<leader>dk", dap.step_back, { desc = "DAP Step Back" })
      vim.keymap.set("n", "<leader>dx", dap.restart, { desc = "DAP Restart" })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
