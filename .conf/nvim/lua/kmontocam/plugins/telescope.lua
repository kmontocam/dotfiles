return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")

    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}

      filepath = vim.fn.expand(filepath)
      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
          return nil
        end
        if stat.size > 1048576 then
          return nil
        else
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
      end)
    end

    telescope.setup({
      defaults = {
        buffer_previewer_maker = new_maker,
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-K>"] = actions.move_selection_previous,
            ["<C-J>"] = actions.move_selection_next,
            ["<C-Q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")

    vim.keymap.set(
      "n",
      "<leader>?",
      "<cmd>Telescope oldfiles<cr>",
      { desc = "[?] Find recently opened files" }
    )
    vim.keymap.set(
      "n",
      "<leader><space>",
      "<cmd>Telescope buffers<cr>",
      { desc = "[ ] Find existing buffers" }
    )
    vim.keymap.set(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      { desc = "[S]earch [F]iles" }
    )
    vim.keymap.set(
      "n",
      "<leader>fs",
      "<cmd>Telescope live_grep<cr>",
      { desc = "[S]earch by [G]rep" }
    )
    vim.keymap.set(
      "n",
      "<leader>fc",
      "<cmd>Telescope grep_string<cr>",
      { desc = "[S]earch current [W]ord" }
    )
    vim.keymap.set(
      "n",
      "<leader>fd",
      "<cmd>Telescope diagnostics<cr>",
      { desc = "[S]earch [D]iagnostics" }
    )
    vim.keymap.set(
      "n",
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      { desc = "[S]earch [H]elp" }
    )
    vim.keymap.set(
      "n",
      "<leader>fr",
      "<cmd>Telescope resume<cr>",
      { desc = "[S]earch [R]esume" }
    )
    vim.keymap.set(
      "n",
      "<leader>fk",
      "<cmd>Telescope keymaps<cr>",
      { desc = "[S]earch [R]esume" }
    )
    vim.keymap.set(
      "n",
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      { desc = "[S]earch [U]ndo" }
    )
  end,
}
