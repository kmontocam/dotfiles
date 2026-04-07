return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
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
      jq = {
        command = "jq",
        args = { "--sort-keys" },
        stdin = true,
      },
      yq = {
        command = "yq",
        args = { "-P", "sort_keys(..)" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      css = { "prettier" },
      eruby = { "erb_format" },
      groovy = { "npm-groovy-lint" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier", "jq" },
      jsonc = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      nix = { "nixfmt" },
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
    format_on_save = function(bufnr)
      local buffer_autofmt = vim.b[bufnr].autoformat
      if buffer_autofmt ~= nil then
        if not buffer_autofmt then
          return nil
        end
      elseif vim.g.autoformat == false then
        return nil
      end
      return {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end,
  },
}
