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
        "pyright",
        "sqlls",
        "bashls",
        "clangd",
        "html",
        "cssls",
        "tsserver",
        "rust_analyzer",
        "lua_ls",
        "emmet_ls",
        "dockerls",
        "docker_compose_language_service",
      },
      automatic_installation = true,
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "stylua",
        "black",
        "pylint",
        "isort",
        "sql-formatter",
        "prettier",
        "markdownlint",
      },
    })
    vim.keymap.set("n", "<leader>ma", "<cmd>Mason<cr>", { desc = "Toggle Mason" })
  end,
}
