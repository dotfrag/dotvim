if vim.g.picker ~= "mini" then
  return
end

require("mini.pick").setup()
vim.keymap.set("n", "<leader>sf", ":Pick files<CR>")
vim.keymap.set("n", "<leader>sh", ":Pick help<CR>")
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
