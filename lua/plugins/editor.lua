require("guess-indent").setup({})
require("nvim-surround").setup()

if vim.g.pairs == "autopairs" then
  require("nvim-autopairs").setup()
end
