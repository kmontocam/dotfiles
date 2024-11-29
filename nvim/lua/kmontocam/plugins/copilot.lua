return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = false },
    filetypes = {
      lua = true,
      python = true,
      rust = true,
    },
  },
}
