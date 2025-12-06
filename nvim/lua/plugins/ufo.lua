return {
  "kevinhwang91/nvim-ufo",
  event = "BufRead",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local ufo = require("ufo")

    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zK", function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })

    ufo.setup({
      provider_selector = function(_, _, _)
        return { "lsp", "indent" }
      end,
    })
  end,
}
