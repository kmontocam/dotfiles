return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters = {
        sql_formatter = {
          args = (function()
            local config_path = vim.fn.getcwd() .. "/.sql-formatter.json"
            if vim.fn.filereadable(config_path) == 1 then
              return { "--config", config_path }
            else
              return {}
            end
          end)(),
        },
      },

      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        sql = { "sql_formatter" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        groovy = { "npm-groovy-lint" },
        ["*"] = { "injected" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
