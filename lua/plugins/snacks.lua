---@type snacks.Config
require("snacks").setup({
  words = { enabled = true },
})

-- Lazygit
vim.keymap.set("n", "<A-g>", function()
  Snacks.lazygit({ win = { width = 0, height = 0 } })
end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ win = { width = 0, height = 0 } })
end, { desc = "Lazygit" })
