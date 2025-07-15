return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "b0o/SchemaStore.nvim" },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>lr", ":LspRestart<cr>", "Restart")
      nmap("<leader>grn", vim.lsp.buf.rename, "Rename")
      nmap("<leader>gra", vim.lsp.buf.code_action, "Code Action")
      nmap("grd", "<cmd>Telescope lsp_definitions<cr>", "Goto definition")
      nmap("grD", "<cmd>tab split | Telescope lsp_definitions<cr>", "Goto definition in new tab")
      nmap("grW", "<cmd>wincmd v | Telescope lsp_definitions<cr>", "Goto definition in splitted vertical window")
      nmap("grr", "<cmd>Telescope lsp_references<cr>", "Goto references")
      nmap("gri", "<cmd>Telescope lsp_implementations<cr>", "Goto implementation")
      nmap("grt", "<cmd>Telescope lsp_type_definitions<cr>", "Type definition")
      nmap("<leader>gO", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
      nmap("<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols")

      nmap("K", vim.lsp.buf.hover, "Hover documentation")

      nmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics")
      nmap("gro", vim.lsp.buf.declaration, "Goto declaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "sh", "zsh" },
    })

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["dockerls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["docker_compose_language_service"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["ruby_lsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["groovyls"].setup({
      filetypes = { "groovy" },
      capabilities = capabilities,
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/groovy-language-server" },
      on_attach = on_attach,
    })

    lspconfig["nil_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["jsonls"].setup({
      server_capabilities = {
        documentFormattingProvider = false,
      },
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
      },
    })

    lspconfig["ruff"].setup({
      capabilities = capabilities,
    })

    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["terraformls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["yamlls"].setup({
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
