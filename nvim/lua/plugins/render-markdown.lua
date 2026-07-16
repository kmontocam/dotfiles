return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", branch = "master" },
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    completions = { lsp = { enabled = true } },
    -- also attach to python: renders + completes markdown injected via `# md` strings
    file_types = { "markdown", "python" },
  },
}
