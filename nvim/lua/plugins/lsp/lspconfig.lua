return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "b0o/SchemaStore.nvim" },
    { "folke/snacks.nvim" },
  },
  keys = {
    { "<leader>lr", "<cmd>LspRestart<cr>", desc = "LSP: Restart" },
    { "grn", vim.lsp.buf.rename, desc = "LSP: Rename" },
    { "gra", vim.lsp.buf.code_action, desc = "LSP: Code Action" },
    {
      "grd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "LSP: Goto definition",
    },
    {
      "grD",
      function()
        vim.cmd("tab split")
        Snacks.picker.lsp_definitions()
      end,
      desc = "LSP: Goto definition in new tab",
    },
    {
      "grW",
      function()
        vim.cmd("wincmd v")
        Snacks.picker.lsp_definitions()
      end,
      desc = "LSP: Goto definition in split",
    },
    {
      "grr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "LSP: Goto references",
    },
    {
      "gri",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "LSP: Goto implementation",
    },
    {
      "grt",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "LSP: Type definition",
    },
    {
      "grh",
      function()
        vim.lsp.buf.typehierarchy("subtypes")
      end,
      desc = "LSP: Type hierarchy subtypes",
    },
    {
      "grH",
      function()
        vim.lsp.buf.typehierarchy("supertypes")
      end,
      desc = "LSP: Type hierarchy supertypes",
    },
    { "K", vim.lsp.buf.hover, desc = "LSP: Hover documentation" },
    {
      "<leader>wl",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "LSP: Diagnostics",
    },
    {
      "gro",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "LSP: Goto declaration",
    },
  },
  init = function()
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        vim.api.nvim_buf_create_user_command(ev.buf, "Format", function()
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end,
    })
  end,
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.tbl_deep_extend(
      "force",
      require("cmp_nvim_lsp").default_capabilities(),
      require("lsp-file-operations").default_capabilities()
    )

    -- servers with default config
    local default_servers = {
      "clangd",
      "cssls",
      "dockerls",
      "docker_compose_language_service",
      "html",
      "ruby_lsp",
      "gopls",
      "nil_ls",
      "rust_analyzer",
      "ruff",
      "tailwindcss",
      "taplo",
      "terraformls",
      "ts_ls",
    }

    for _, server in ipairs(default_servers) do
      lspconfig[server].setup({ capabilities = capabilities })
    end

    -- servers with custom config
    lspconfig.bashls.setup({
      capabilities = capabilities,
      filetypes = { "sh", "zsh" },
    })

    lspconfig.groovyls.setup({
      capabilities = capabilities,
      filetypes = { "groovy" },
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/groovy-language-server" },
    })

    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      on_new_config = function(config, root_dir)
        local venv = root_dir .. "/.venv/bin/python"
        -- if project has a .venv, use python interpreter
        if vim.fn.executable(venv) == 1 then
          config.settings.python.pythonPath = venv
        end
      end,
      settings = {
        basedpyright = { disableOrganizeImports = true },
      },
    })

    lspconfig.yamlls.setup({
      capabilities = capabilities,
      settings = {
        yaml = {
          schemas = {
            kubernetes = "base/**/*.{yml,yaml}",
            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
            ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
            ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          },
        },
      },
    })
  end,
}
