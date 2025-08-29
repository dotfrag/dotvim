vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/andrewferrier/debugprint.nvim",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/chrisgrieser/nvim-recorder",
  "https://github.com/chrisgrieser/nvim-rip-substitute",
  "https://github.com/danymat/neogen",
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/persistence.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/monaqa/dial.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-abolish",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd(":hi statusline guibg=NONE")

require("mini.misc").setup()
MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()
MiniMisc.setup_termbg_sync()

local plugins = {
  "oil",
  "dashboard",
  "snacks",
  "treesitter",
  "lsp",
  "conform",
  "bufferline",
}

local plugins_lazy = {
  "editor",
  "mini",
  "git",
  "dial",
  "fzf",
  "neo-tree",
}

for _, plugin in ipairs(plugins) do
  require("plugins." .. plugin)
end

Util.on_vim_enter(function()
  for _, plugin in ipairs(plugins_lazy) do
    require("plugins." .. plugin)
  end
end)
