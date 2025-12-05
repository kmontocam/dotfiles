return {
  "mbbill/undotree",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "<Leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle undotree" })
  end,
}
