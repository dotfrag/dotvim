vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/echasnovski/mini.pick",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/stevearc/oil.nvim",
})

vim.cmd("colorscheme catppuccin")
vim.cmd(":hi statusline guibg=NONE")

require("mini.pick").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "svelte", "typescript", "javascript" },
  highlight = { enable = true },
})
require("oil").setup()

require("plugins.lsp")
