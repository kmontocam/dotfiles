return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
          return
        end
        if stat.size > 1048576 then
          return
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

    vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>", { desc = "Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>", { desc = "Find existing buffers" })
    vim.keymap.set("n", "<leader>/", function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 16,
        previewer = false,
      }))
    end, { desc = "Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Search files" })
    vim.keymap.set(
      "n",
      "<leader>fa",
      "<cmd>Telescope find_files hidden=true<cr>",
      { desc = "Search with hidden files" }
    )
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Search by grep" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Search current word" })
    vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Search diagnostics" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Search help" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Search resume" })
    vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Search keyamps" })
  end,
}
