local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return nil
end

saga.setup({
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	definition = {
		edit = "<CR>",
	},
	lightbulb = {
		sign = false,
	},
	ui = {
		colors = {
			normal_bg = "#022746",
		},
	},
})
