local status, lualine = pcall(require, "lualine")
if not status then
	return nil
end

lualine.setup({
	options = {
		theme = "vscode",
	},
	extensions = { "nvim-tree" },
})
