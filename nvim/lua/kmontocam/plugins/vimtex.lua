return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_compiler_method = "tectonic"
    vim.g.vimtex_format_enabled = 1
  end,
}
