return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    -- generate dynamic port based on process ID to allow multiple nvim sessions
    local base_port = 4096
    local pid = vim.fn.getpid()
    local dynamic_port = base_port + (pid % 1000)

    vim.g.opencode_opts = {
      port = dynamic_port,
      provider = {
        enabled = "tmux",
        tmux = {},
      },
    }

    vim.o.autoread = true

    vim.keymap.set("n", "<leader>oc", function()
      require("opencode").toggle()
    end, { desc = "Toggle embedded" })
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })
    vim.keymap.set("x", "<leader>oc", function()
      require("opencode").prompt("@this")
    end, { desc = "Add to opencode" })
    vim.keymap.set("n", "<leader>ob", function()
      require("opencode").prompt("@buffer", { append = true })
    end, { desc = "Add buffer to prompt" })
    vim.keymap.set("n", "<leader>on", function()
      require("opencode").command("session_new")
    end, { desc = "New session" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Select prompt" })
  end,
}
