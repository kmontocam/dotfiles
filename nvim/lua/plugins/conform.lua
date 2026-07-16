return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters = {
      injected = {
        -- skip embedded regions the formatter chokes on (e.g. f-string/${} interpolations)
        options = { ignore_errors = true },
      },
      jq = {
        command = "jq",
        args = { "--sort-keys" },
        stdin = true,
      },
      yq = {
        command = "yq",
        args = { "-P", "--yaml-compact-seq-indent", "sort_keys(..)" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      css = { "prettier" },
      eruby = { "erb_format" },
      groovy = { "npm-groovy-lint" },
      html = { "prettier" },
      javascript = { "prettier", "injected" },
      javascriptreact = { "prettier", "injected" },
      json = { "prettier", "jq" },
      jsonc = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier", "injected" },
      nix = { "nixfmt" },
      python = { "ruff_format", "injected" },
      ruby = { "rubocop" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      sql = { "sqlfluff" },
      tex = { "latexindent" },
      typescript = { "prettier", "injected" },
      typescriptreact = { "prettier", "injected" },
      yaml = { "yq" },
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
