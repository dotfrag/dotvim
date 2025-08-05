vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/chrisgrieser/nvim-origami",
  "https://github.com/chrisgrieser/nvim-recorder",
  "https://github.com/chrisgrieser/nvim-rip-substitute",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
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
  "snacks",
  "treesitter",
  "lsp",
  "mini",
  "editor",
  "conform",
  "git",
  "neo-tree",
  "fzf",
}

for _, plugin in pairs(plugins) do
  require("plugins." .. plugin)
end
