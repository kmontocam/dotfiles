return {
  "michaelrommel/nvim-silicon",
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
  config = function(_, opts)
    local silicon = require("nvim-silicon")
    silicon.setup(opts)

    vim.keymap.set("v", "<leader>sc", function()
      silicon.clip()
    end, { desc = "Copy code screenshot to clipboard" })
    vim.keymap.set("v", "<leader>sf", function()
      silicon.file()
    end, { desc = "Save code screenshot as file" })
  end,
}
