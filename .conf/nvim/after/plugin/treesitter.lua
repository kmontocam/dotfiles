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
		"python",
		"r",
		"sql",
		"matlab",
		"c",
		"cpp",
		"regex",
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
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
