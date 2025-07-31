vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/stevearc/oil.nvim",
})

vim.cmd("colorscheme catppuccin")
vim.cmd(":hi statusline guibg=NONE")

require("nvim-treesitter.configs").setup({
  ensure_installed = { "bash", "svelte", "typescript", "javascript" },
  highlight = { enable = true },
})

local plugins = {
  "oil",
  "lsp",
  "mini",
  "surround",
}

for _, plugin in pairs(plugins) do
  require("plugins." .. plugin)
end
