vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", ":Ex<cr>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete without copying into register" })

vim.keymap.set("n", "<leader>+", "<C-A>", { desc = "Increment number under cursor" })
vim.keymap.set("n", "<leader>-", "<C-X>", { desc = "Decrement number under cursor" })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-D>", "<C-d>zz")
vim.keymap.set("n", "<C-U>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dp]], { desc = "Paste without copying into register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]], { desc = "Cut to system clipboard" })

vim.keymap.set("n", "<leader>sv", "<C-W>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-W>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sw", "<C-W>x", { desc = "Swap current window with next" })
vim.keymap.set("n", "<leader>se", "<C-W>=", { desc = "Make split windows equal width and height" })

vim.keymap.set("n", "<leader>to", ":tabnew<cr>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<cr>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<cr>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<cr>", { desc = "Go to previous tab" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>m", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>du", function()
  local enabled = true

  if vim.diagnostic.is_enabled then
    enabled = vim.diagnostic.is_enabled()
  elseif vim.diagnostic.is_disabled then
    enabled = not vim.diagnostic.is_disabled()
  end

  enabled = not enabled

  if enabled then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end, { desc = "Toggle diagnostics" })
