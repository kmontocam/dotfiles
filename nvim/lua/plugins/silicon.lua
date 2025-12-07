return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  opts = {
    font = "JetBrainsMono Nerd Font=34",
    theme = "Visual Studio Dark+",
    pad_horiz = 0,
    pad_vert = 0,
    window_title = function()
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
    end,
    output = function()
      return os.getenv("HOME") .. "/Downloads/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
    end,
  },
  keys = {
    {
      "<leader>sc",
      function()
        require("nvim-silicon").clip()
      end,
      mode = "v",
      desc = "Copy code screenshot to clipboard",
    },
    {
      "<leader>sf",
      function()
        require("nvim-silicon").file()
      end,
      mode = "v",
      desc = "Save code screenshot as file",
    },
  },
}
