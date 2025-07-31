require("guess-indent").setup({})
require("nvim-surround").setup()

if vim.g.pairs == "autopairs" then
  vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
  require("nvim-autopairs").setup()
end
