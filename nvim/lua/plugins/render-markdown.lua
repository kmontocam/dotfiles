return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", branch = "master" },
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    completions = { lsp = { enabled = true } },
    file_types = { "markdown", "python" },
    injections = {
      python = {
        enabled = true,
        query = [[
          (module
            (comment) @_lang
            .
            (expression_statement
              (assignment
                right: (string
                  (string_content) @injection.content)))
            (#lua-match? @_lang "^#%s*markdown")
            (#set! injection.language "markdown"))

          (module
            (comment) @_lang
            .
            (expression_statement
              (string
                (string_content) @injection.content))
            (#lua-match? @_lang "^#%s*markdown")
            (#set! injection.language "markdown"))
        ]],
      },
    },
  },
}
