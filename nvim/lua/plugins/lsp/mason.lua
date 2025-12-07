return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {},
  keys = {
    { "<leader>ma", "<cmd>Mason<cr>", desc = "Toggle Mason" },
  },
  config = function(_, opts)
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup(opts)

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "emmet_ls",
        "gopls",
        "groovyls",
        "html",
        "ruby_lsp",
        "jsonls",
        "lua_ls",
        "nil_ls",
        "tailwindcss",
        "pyright",
        "rust_analyzer",
        "sqls",
        "terraformls",
        "ts_ls",
        "yamlls",
      },
      automatic_installation = true,
      automatic_enable = false,
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "debugpy",
        "erb-formatter",
        "erb-lint",
        "eslint_d",
        "latexindent",
        "markdownlint",
        "npm-groovy-lint",
        "prettier",
        "rubocop",
        "ruff",
        "shfmt",
        "sql-formatter",
        "stylua",
      },
    })
  end,
}
