local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return nil
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return nil
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return nil
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"pyright",
		"sqlls",
		"bashls",
		"clangd",
		"html",
		"cssls",
		"tsserver",
		"rust_analyzer",
		"lua_ls",
		"emmet_ls",
		"dockerls",
		"docker_compose_language_service",
	},
	automatic_installation = true,
})

mason_null_ls.setup({
	ensure_installed = {
		"autopep8",
		"sql-formatter",
		"stylua",
		"markdownlint",
		"prettier",
	},
	automatic_installation = true,
})
