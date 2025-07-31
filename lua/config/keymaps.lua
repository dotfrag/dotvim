local map = vim.keymap.set

-- Buffer
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set({ "n", "i" }, "<C-s>", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

-- Save buffer
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>')

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>d", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
-- map("n", "<leader>ba", function() Snacks.bufdelete.all() end, { desc = "Delete All Buffers" })
-- map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
map("n", "<leader>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>-", "<C-w>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-w>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", remap = true })
