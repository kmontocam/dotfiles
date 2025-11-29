return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.g.opencode_opts = {
      port = 4096,
      provider = {
        enabled = "tmux",
        tmux = {},
      },
    }

    vim.o.autoread = true
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "x" }, "go", function()
      require("opencode").prompt("@this")
    end, { desc = "Add to opencode" })
  end,
}
