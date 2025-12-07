return {
  "NickvanDyke/opencode.nvim",
  lazy = true,
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  keys = {
    {
      "<leader>oc",
      function()
        require("opencode").toggle()
      end,
      mode = "n",
      desc = "Toggle embedded",
    },
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "Ask opencode",
    },
    {
      "<leader>ob",
      function()
        require("opencode").prompt("@this")
      end,
      mode = "x",
      desc = "Add to opencode",
    },
    {
      "<leader>ob",
      function()
        require("opencode").prompt("@buffer", { append = true })
      end,
      mode = "n",
      desc = "Add buffer to prompt",
    },
    {
      "<leader>on",
      function()
        require("opencode").command("session_new")
      end,
      mode = "n",
      desc = "New session",
    },
    {
      "<leader>os",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Select prompt",
    },
  },
  init = function()
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
  end,
}
