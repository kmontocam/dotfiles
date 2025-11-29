return {
  "jpalardy/vim-slime",
  event = "VeryLazy",
  init = function()
    vim.g.slime_no_mappings = 1
    vim.g.slime_dont_ask_default = 1
  end,
  config = function()
    vim.g.slime_target = "tmux"
    vim.cmd([[
	  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
	  let g:slime_bracketed_paste = 1
	]])
    vim.keymap.set("n", "<leader>mc", "<Plug>SlimeConfig", { desc = "Config vim-slime" })
    vim.keymap.set("n", "<leader>mp", "<Plug>SlimeParagraphSend", { desc = "Send paragraph to next tmux pane" })
    vim.keymap.set("v", "<leader>mm", "<Plug>SlimeRegionSend", { desc = "Send selected to next tmux pane" })
  end,
}
