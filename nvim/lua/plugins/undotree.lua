return {
  "mbbill/undotree",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<Leader>ut", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
  },
}
