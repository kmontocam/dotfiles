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
        yq = {
          command = "yq",
          args = { "-P", "sort_keys(..)" },
          stdin = true,
        },
      },

      formatters_by_ft = {
        ["*"] = { "injected" },
        css = { "prettier" },
        eruby = { "erb_format" },
        groovy = { "npm-groovy-lint" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "ruff_format" },
        ruby = { "rubocop" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        tex = { "latexindent" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier", "yq" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })
  end,
}
