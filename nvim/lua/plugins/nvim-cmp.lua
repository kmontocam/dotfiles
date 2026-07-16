---@diagnostic disable: missing-fields
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        local luasnip = require("luasnip")
        luasnip.setup({
          ft_func = function()
            local ok, parser = pcall(vim.treesitter.get_parser)
            if ok and parser then
              local row = vim.api.nvim_win_get_cursor(0)[1] - 1
              parser:parse({ row, row })
            end
            return require("luasnip.extras.filetype_functions").from_pos_or_filetype()
          end,
        })
        -- inline markdown text parses as markdown_inline; serve markdown snippets there too
        -- markdown must load eagerly: lazy_load only fires on FileType events,
        -- which never happen for filetypes that only exist as injections
        luasnip.filetype_extend("markdown_inline", { "markdown" })
        require("luasnip.loaders.from_vscode").load({ include = { "markdown" } })
        require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "markdown" } })
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    {
      "onsails/lspkind.nvim",
      opts = {
        symbol_map = {
          Copilot = "",
        },
      },
    },
    {
      "zbirenbaum/copilot-cmp",
      opts = {},
    },
  },
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    return {
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-B>"] = cmp.mapping.scroll_docs(-4),
        ["<C-F>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-E>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  end,
}
