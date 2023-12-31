return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup()
    mason_tool_installer.setup({
      ensure_installed = {
        "stylua",
      },
    })
    vim.keymap.set("n", "<leader>ma", "<cmd>Mason<cr>", { desc = "Toggle Mason" })
  end,
}
