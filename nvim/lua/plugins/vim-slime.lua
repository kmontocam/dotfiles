return {
  "jpalardy/vim-slime",
  lazy = true,
  keys = {
    { "<leader>mc", "<Plug>SlimeConfig", mode = "n", desc = "Config vim-slime" },
    { "<leader>mp", "<Plug>SlimeParagraphSend", mode = "n", desc = "Send paragraph to next tmux pane" },
    { "<leader>mm", "<Plug>SlimeRegionSend", mode = "v", desc = "Send selected to next tmux pane" },
  },
  init = function()
    vim.g.slime_no_mappings = 1
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_target = "tmux"
  end,
  config = function()
    vim.cmd([[
	  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
	  let g:slime_bracketed_paste = 1
	]])
  end,
}
