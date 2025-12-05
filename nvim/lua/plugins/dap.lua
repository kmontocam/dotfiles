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

      local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

      require("dap-python").setup(debugpy_path)

      local function create_python_attach_config(remoteRoot)
        return {
          connect = {
            host = "localhost",
            port = 5678,
          },
          justMyCode = false,
          name = "Attach to debugpy container running in `" .. remoteRoot .. "`",
          pathMappings = {
            {
              localRoot = "${workspaceFolder}",
              remoteRoot = remoteRoot,
            },
          },
          redirectOutput = true,
          request = "attach",
          type = "python",
        }
      end

      dap.configurations.python = {
        create_python_attach_config("/opt"),
        create_python_attach_config("/app"),
      }

      ---@diagnostic disable-next-line: missing-fields
      require("dapui").setup({
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.5,
              },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.125 },
              { id = "watches", size = 0.125 },
            },
            size = 64,
            position = "left",
          },
          {
            elements = {
              {
                id = "repl",
                size = 0.75,
              },
              {
                id = "console",
                size = 0.25,
              },
            },
            size = 16,
            position = "bottom",
          },
        },
      })
      ---@diagnostic disable-next-line: missing-parameter
      require("nvim-dap-virtual-text").setup({
        all_frames = true,
        commented = true,
        virt_text_pos = "eol",
      })

      vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>br", dap.run_to_cursor, { desc = "DAP Run to Cursor" })

      vim.keymap.set("n", "<leader>b?", function()
        ---@diagnostic disable-next-line: missing-fields
        require("dapui").eval(nil, { enter = true })
      end, { desc = "DAP Eval Expression" })

      vim.keymap.set("n", "<leader>bc", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<leader>bi", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<leader>bo", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<leader>bu", dap.step_out, { desc = "DAP Step Out" })
      vim.keymap.set("n", "<leader>bk", dap.step_back, { desc = "DAP Step Back" })
      vim.keymap.set("n", "<leader>bx", dap.restart, { desc = "DAP Restart" })
      vim.keymap.set("n", "<leader>bR", function()
        ui.open({ reset = true })
      end, { desc = "DAP Reset Layout Sizes" })

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
