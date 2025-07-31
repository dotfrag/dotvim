vim.pack.add({ {
  src = "https://github.com/nvim-treesitter/nvim-treesitter",
  version = "main",
} })

require("nvim-treesitter.configs").setup({
  ensure_installed = { "bash", "svelte", "typescript", "javascript" },
  highlight = { enable = true },
})
