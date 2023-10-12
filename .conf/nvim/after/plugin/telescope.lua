local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return nil
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return nil
end

local previewers_setup, previewers = pcall(require, "telescope.previewers")
if not previewers_setup then
	return nil
end

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return nil
		end
		if stat.size > 1048576 then
			return nil
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

telescope.setup({
	defaults = {
		buffer_previewer_maker = new_maker,
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
