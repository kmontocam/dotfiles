return {
  "jpalardy/vim-slime",
  event = "VeryLazy",
  config = function()
    vim.g.slime_target = "tmux"
    vim.cmd([[
	  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
	  let g:slime_bracketed_paste = 1
	]])
  end,
}
