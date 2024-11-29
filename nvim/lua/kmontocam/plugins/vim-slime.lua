return {
  "jpalardy/vim-slime",
  event = "VeryLazy",
  config = function()
    vim.g.slime_target = "tmux"
    vim.cmd([[
	  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
	  let g:slime_bracketed_paste = 1
	]])
    vim.keymap.set("n", "<Leader>oc", "<Plug>SlimeConfig", { desc = "Config vim-slime" })
    vim.keymap.set("n", "<Leader>op", "<Plug>SlimeParagraphSend", { desc = "Send paragraph to next tmux pane" })
    vim.keymap.set("v", "<Leader>oo", "<Plug>SlimeRegionSend", { desc = "Send selected to next tmux pane" })
  end,
}
