return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      vim.treesitter.language.register("bash", "zsh")

      treesitter.setup({
        build = ":TSUpdate",
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        autotag = {
          enable = true,
        },
        ensure_installed = {
          "regex",
          "json",
          "csv",
          "yaml",
          "toml",
          "bash",
          "lua",
          "vim",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-S>",
            node_decremental = "<BS>",
          },
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["a="] = {
                query = "@assignment.outer",
                desc = "Select outer part of an assignment",
              },
              ["i="] = {
                query = "@assignment.inner",
                desc = "Select inner part of an assignment",
              },
              ["l="] = {
                query = "@assignment.lhs",
                desc = "Select left hand side of an assignment",
              },
              ["r="] = {
                query = "@assignment.rhs",
                desc = "Select right hand side of an assignment",
              },

              ["a:"] = {
                query = "@property.outer",
                desc = "Select outer part of an object property",
              },
              ["i:"] = {
                query = "@property.inner",
                desc = "Select inner part of an object property",
              },
              ["l:"] = {
                query = "@property.lhs",
                desc = "Select left part of an object property",
              },
              ["r:"] = {
                query = "@property.rhs",
                desc = "Select right part of an object property",
              },

              ["aa"] = {
                query = "@parameter.outer",
                desc = "Select outer part of a parameter/argument",
              },
              ["ia"] = {
                query = "@parameter.inner",
                desc = "Select inner part of a parameter/argument",
              },

              ["ai"] = {
                query = "@conditional.outer",
                desc = "Select outer part of a conditional",
              },
              ["ii"] = {
                query = "@conditional.inner",
                desc = "Select inner part of a conditional",
              },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["am"] = {
                query = "@call.outer",
                desc = "Select outer part of a function call",
              },
              ["im"] = {
                query = "@call.inner",
                desc = "Select inner part of a function call",
              },

              ["af"] = {
                query = "@function.outer",
                desc = "Select outer part of a method/function definition",
              },
              ["if"] = {
                query = "@function.inner",
                desc = "Select inner part of a method/function definition",
              },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = { query = "@call.outer", desc = "Next function call start" },
              ["]f"] = {
                query = "@function.outer",
                desc = "Next method/function def start",
              },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            },
            goto_next_end = {
              ["]M"] = { query = "@call.outer", desc = "Next function call end" },
              ["]F"] = {
                query = "@function.outer",
                desc = "Next method/function def end",
              },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[m"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[f"] = {
                query = "@function.outer",
                desc = "Prev method/function def start",
              },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[M"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[F"] = {
                query = "@function.outer",
                desc = "Prev method/function def end",
              },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>nf"] = "@function.outer",
            },
            swap_previous = {
              ["<leader>pf"] = "@function.outer",
            },
          },
        },
      })
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },
}
