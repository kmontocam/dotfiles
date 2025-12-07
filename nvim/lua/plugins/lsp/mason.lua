return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)
    -- load lspconfig once mason is ready
    require("mason-lspconfig").setup({
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
        "basedpyright",
        "rust_analyzer",
        "sqls",
        "terraformls",
        "ts_ls",
        "yamlls",
      },
      automatic_installation = true,
      automatic_enable = false,
    })
    require("mason-tool-installer").setup({
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
  keys = {
    { "<leader>ma", "<cmd>Mason<cr>", desc = "Open Mason" },
  },
}
