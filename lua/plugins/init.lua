vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/windwp/nvim-autopairs",
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
  "git",
}

for _, plugin in pairs(plugins) do
  require("plugins." .. plugin)
end
