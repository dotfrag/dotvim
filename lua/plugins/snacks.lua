---@type snacks.Config
require("snacks").setup({
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  notify = { enabled = true },
  words = { enabled = true },
})

-- stylua: ignore start

-- Words
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "next reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
vim.keymap.set({ "n", "t" }, "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev Reference" })

-- Lazygit
vim.keymap.set("n", "<A-g>", function() Snacks.lazygit({ win = { width = 0, height = 0 } }) end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit({ win = { width = 0, height = 0 } }) end, { desc = "Lazygit" })
