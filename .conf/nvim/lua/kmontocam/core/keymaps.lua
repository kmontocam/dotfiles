vim.g.mapleader = " "

-- general

vim.keymap.set("n", "<leader>pv", ":Ex<CR>") -- open file explorer
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "x", '"_x') -- delete single character without copying into register

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>") -- increment
vim.keymap.set("n", "<leader>-", "<C-x>") -- decrement

--- move selection
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- move and remain cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste special
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]])

-- replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- movement

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<cr>") -- close current split window

vim.keymap.set("n", "<leader>to", ":tabnew<cr>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<cr>") -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<cr>") --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<cr>") --  go to previous tab

-- plugins

vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<cr>") -- toggle split window maximization
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>") -- toggle file explorer

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

vim.keymap.set("n", "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
vim.keymap.set("n", "<C-N>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")
vim.keymap.set("n", "<C-M>", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>")

-- vim-slime
vim.g.slime_target = "tmux"
vim.cmd([[
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
    let g:slime_bracketed_paste = 1
    " let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.3"}
]])
