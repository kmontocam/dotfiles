vim.keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete without copying into register" })

vim.keymap.set("n", "<leader>ni", "<C-A>", { desc = "Increment number under cursor" })
vim.keymap.set("n", "<leader>nd", "<C-X>", { desc = "Decrement number under cursor" })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dp]], { desc = "Paste without copying into register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })

vim.keymap.set("n", "<leader><C-G>", function()
  local filepath = vim.fn.expand("%")
  vim.fn.setreg("+", filepath)
end, { desc = "Copy relative file path to system clipboard" })

vim.keymap.set("n", "<leader>sv", "<C-W>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-W>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sw", "<C-W>x", { desc = "Swap current window with next" })
vim.keymap.set("n", "<leader>se", "<C-W>=", { desc = "Make split windows equal width and height" })

vim.keymap.set("n", "<leader>to", ":tabnew<cr>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<cr>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<cr>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<cr>", { desc = "Go to previous tab" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({
    count = -1,
    float = true,
  })
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({
    count = 1,
    float = true,
  })
end, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>dm", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.keymap.set("x", "<leader>ss", ":sort<cr>", { desc = "Sort selected lines" })
vim.keymap.set("n", "<leader><C-R>", ":e!<cr>", { desc = "Reload file from disk" })

vim.keymap.set("n", "<leader>-", "<cmd>foldclose<cr>", { desc = "Close fold" })
vim.keymap.set("n", "<leader>+", "<cmd>foldopen<cr>", { desc = "Open fold" })
