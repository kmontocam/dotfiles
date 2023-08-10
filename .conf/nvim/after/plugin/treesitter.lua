local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return nil
end

treesitter.setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	autotag = { enable = true },
	ensure_installed = {
		"yaml",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
	},
	auto_install = true,
})
