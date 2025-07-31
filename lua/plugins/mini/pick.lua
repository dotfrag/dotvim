if vim.g.picker ~= "mini" then
  return
end

require("mini.pick").setup({
  mappings = {
    move_down = "<C-j>",
    move_up = "<C-k>",
  },
})
require("mini.extra").setup()

vim.keymap.set("n", "<leader>.", ":Pick resume<cr>")

vim.keymap.set("n", "<leader>sf", ":Pick files<cr>")
vim.keymap.set("n", "<leader>sh", ":Pick help<cr>")
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<cr>")
vim.keymap.set("n", "<leader>so", ":Pick options<cr>")
vim.keymap.set("n", "<leader>sd", ":Pick diagnostic<cr>")
vim.keymap.set("n", "<leader>sC", ":Pick commands<cr>")
vim.keymap.set("n", "<leader>sc", ":Pick history scope=':'<cr>")

vim.keymap.set("n", "<leader>/", ":Pick buf_lines scope='current'<cr>")
