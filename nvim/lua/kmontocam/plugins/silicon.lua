return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  init = function()
    vim.keymap.set("v", "<leader>sc", ":Silicon<cr>", { desc = "Snapshot Code" })
  end,
  config = function()
    local silicon = require("silicon")
    silicon.setup({
      font = "SFMono Nerd Font=34",
      theme = "Visual Studio Dark+",
      background = "#f7f0d5",
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
      end,
      output = function()
        return os.getenv("HOME") .. "/Downloads/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
      end,
    })
  end,
}
