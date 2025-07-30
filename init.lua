-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Globals
-- _G.Util = require("util")

-- Load config
require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/folke/lazydev.nvim" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd("set completeopt+=noselect")

require("mini.pick").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "svelte", "typescript", "javascript" },
  highlight = { enable = true },
})
require("oil").setup()

vim.lsp.enable({ "lua_ls", "biome", "emmetls" })

vim.cmd("colorscheme tokyonight-night")
vim.cmd(":hi statusline guibg=NONE")

require("mason").setup()

require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
