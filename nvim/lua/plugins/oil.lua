return {
  "stevearc/oil.nvim",
  event = { "VimEnter */*,.*", "BufNew */*,.*" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions[1].type == "move" then
          Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
        end
      end,
    })
  end,
  keys = {
    {
      mode = "n",
      "<leader>e",
      "<cmd>Oil<cr>",
      desc = "Open the Oil file viewer",
    },
  },
  opts = {
    delete_to_trash = true,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 8000,
      autosave_changes = "unmodified",
    },
    keymaps = {
      ["<leader>e"] = { "actions.close", mode = "n" },
      ["<leader>b"] = { "actions.select", opts = { horizontal = true } },
      ["<leader>r"] = "actions.refresh",
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
  },
}
