vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/folke/tokyonight.nvim",
})

vim.cmd("colorscheme catppuccin")
vim.cmd(":hi statusline guibg=NONE")

local plugins = {
  "oil",
  "treesitter",
  "lsp",
  "mini",
  "editor",
  "conform",
}

for _, plugin in pairs(plugins) do
  require("plugins." .. plugin)
end
