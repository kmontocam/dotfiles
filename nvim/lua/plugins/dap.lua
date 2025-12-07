return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
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

      local function breakpoint_picker()
        local dap_breakpoints = require("dap.breakpoints")
        local devicons = require("nvim-web-devicons")

        Snacks.picker.pick({
          source = "dap_breakpoints",
          title = "DAP Breakpoints",
          finder = function()
            local items = {}
            local breakpoints = dap_breakpoints.get()

            for bufnr, buf_bps in pairs(breakpoints) do
              -- get buffer name and make it relative to cwd
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              if bufname == "" then
                bufname = "[No Name]"
              else
                bufname = vim.fn.fnamemodify(bufname, ":~:.")
              end

              for _, bp in ipairs(buf_bps) do
                -- get the line content to highlight the entire line in preview
                local line_content = ""
                if vim.api.nvim_buf_is_loaded(bufnr) then
                  local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, bp.line - 1, bp.line, false)
                  if ok and lines and lines[1] then
                    line_content = lines[1]
                  end
                end

                -- create positions array to highlight the entire line
                local positions = {}
                if line_content ~= "" then
                  for i = 1, #line_content do
                    table.insert(positions, i - 1) -- 0-indexed columns
                  end
                end

                table.insert(items, {
                  bufnr = bufnr,
                  line = bp.line,
                  text = bufname .. ":" .. bp.line,
                  file = bufname,
                  condition = bp.condition,
                  logMessage = bp.logMessage,
                  hitCondition = bp.hitCondition,
                  pos = { bp.line, 0 }, -- position for preview: {line, col}
                  positions = #positions > 0 and positions or nil, -- positions to highlight
                  preview = {
                    file = vim.api.nvim_buf_get_name(bufnr),
                    line = bp.line,
                  },
                })
              end
            end

            return items
          end,
          format = function(item, _)
            local ret = {}
            -- add file icon
            local icon, hl = devicons.get_icon(item.file, vim.fn.fnamemodify(item.file, ":e"), { default = true })
            if icon then
              table.insert(ret, { icon .. " ", hl or "DevIconDefault" })
            end
            -- add filename
            local filename = vim.fn.fnamemodify(item.file, ":t")
            local dir = vim.fn.fnamemodify(item.file, ":h")
            if dir ~= "." then
              table.insert(ret, { dir .. "/", "SnacksPickerDir" })
            end
            table.insert(ret, { filename, "SnacksPickerFile" })
            -- add line number
            table.insert(ret, { ":", "SnacksPickerFile" })
            table.insert(ret, { tostring(item.line), "SnacksPickerIdx" })
            -- add indicators
            if item.condition then
              table.insert(ret, { " [C]", "SnacksPickerSpecial" })
            end
            if item.logMessage then
              table.insert(ret, { " [L]", "SnacksPickerSpecial" })
            end
            if item.hitCondition then
              table.insert(ret, { " [H]", "SnacksPickerSpecial" })
            end
            return ret
          end,
          preview = "file",
          confirm = function(picker, item)
            picker:close()
            if item then
              vim.api.nvim_set_current_buf(item.bufnr)
              vim.api.nvim_win_set_cursor(0, { item.line, 0 })
              vim.cmd("normal! zz")
            end
          end,
          actions = {
            delete_breakpoint = function(picker, _)
              local selected = picker:selected({ fallback = true })
              for _, item in ipairs(selected) do
                if item.bufnr and item.line then
                  dap_breakpoints.remove(item.bufnr, item.line)
                end
              end
              -- refresh picker if breakpoints remain, otherwise close
              local remaining_breakpoints = dap_breakpoints.get()
              if next(remaining_breakpoints) == nil then
                picker:close()
              else
                picker:refresh()
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<C-X>"] = { "delete_breakpoint", mode = { "i", "n" }, desc = "Delete Breakpoint" },
              },
            },
            list = {
              keys = {
                ["<C-X>"] = { "delete_breakpoint", mode = { "n" }, desc = "Delete Breakpoint" },
              },
            },
          },
        })
      end

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
      vim.keymap.set("n", "<leader>fb", breakpoint_picker, { desc = "Find DAP Breakpoints" })

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
