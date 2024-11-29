return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "folke/neodev.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local neodev = require("neodev")

    neodev.setup()

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>lr", ":LspRestart<cr>", "Restart")
      nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

      nmap("gd", "<cmd>Telescope lsp_definitions<cr>", "Goto definition")
      nmap("gD", "<cmd>tab split | Telescope lsp_definitions<cr>", "Goto definition in new tab")
      nmap("gW", "<cmd>wincmd v | Telescope lsp_definitions<cr>", "Goto definition in splitted vertical window")
      nmap("gr", "<cmd>Telescope lsp_references<cr>", "Goto references")
      nmap("gI", "<cmd>Telescope lsp_implementations<cr>", "Goto implementation")
      nmap("gt", "<cmd>Telescope lsp_type_definitions<cr>", "Type definition")
      nmap("<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
      nmap("<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols")

      nmap("K", vim.lsp.buf.hover, "Hover documentation")

      -- Lesser used LSP functionality
      nmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics")
      nmap("go", vim.lsp.buf.declaration, "Goto declaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "Workspace list folders")

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

    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "sh", "zsh" },
    })

    lspconfig["sqlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["terraformls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["dockerls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["docker_compose_language_service"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig["angularls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
  end,
}
