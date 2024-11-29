return {
  "mbbill/undotree",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "<Leader>u", ":UndotreeToggle<cr>", { desc = "Toggle undotree" })
  end,
}
