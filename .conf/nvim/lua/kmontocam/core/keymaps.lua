vim.g.mapleader = " "

-- general

vim.keymap.set("n", "<leader>pv", ":Ex<cr>")
vim.keymap.set("n", "<leader>nh", ":nohl<cr>")
vim.keymap.set("n", "x", '"_x') -- delete single character without copying into register

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-A>")
vim.keymap.set("n", "<leader>-", "<C-X>")

--- move selection
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- move and remain cursor centered
vim.keymap.set("n", "<C-D>", "<C-d>zz")
vim.keymap.set("n", "<C-U>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste special
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]])

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<cr>") -- close current split window

vim.keymap.set("n", "<leader>to", ":tabnew<cr>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<cr>") -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<cr>") --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<cr>") --  go to previous tab

-- diagnostics
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous diagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { desc = "Go to next diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>m",
  vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>d",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostics list" }
)
