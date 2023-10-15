return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
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

      nmap("<leader>lr", ":LspRestart<CR>", "Restart")
      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
      nmap("gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
      nmap("gI", "<cmd>Telescope lsp_implementations<cr>", "[G]oto [I]mplementation")
      nmap("gt", "<cmd>Telescope lsp_type_definitions<cr>", "Type [D]efinition")
      nmap(
        "<leader>ds",
        "<cmd>Telescope lsp_document_symbols<cr>",
        "[D]ocument [S]ymbols"
      )
      nmap(
        "<leader>ws",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "[W]orkspace [S]ymbols"
      )

      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-K>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", "[D]iagnostics")
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap(
        "<leader>wr",
        vim.lsp.buf.remove_workspace_folder,
        "[W]orkspace [R]emove Folder"
      )
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

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

    lspconfig["dockerls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["docker_compose_language_service"].setup({
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
