return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup()
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
        "nil_ls",
        "html",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "sqlls",
        "terraformls",
        "ts_ls",
        "rust_analyzer",
      },
      automatic_installation = true,
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "eslint_d",
        "latexindent",
        "markdownlint",
        "shfmt",
        "npm-groovy-lint",
        "prettier",
        "sql-formatter",
        "stylua",
        "ruff",
        "rustfmt",
      },
    })
    vim.keymap.set("n", "<leader>ma", "<cmd>Mason<cr>", { desc = "Toggle Mason" })
  end,
}
