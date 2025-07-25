return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        opts = {},
      },
      {
        "mason-org/mason-lspconfig.nvim",
        -- either start this plugin or use vim.lsp.enable()
        -- opts = {},
      },
      "saghen/blink.cmp",
    },
    config = function()
      Util.lsp.attach()
      Util.lsp.diagnostic.config()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      for server, config in pairs(Util.lsp.servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      local opts = Util.opts("nvim-lspconfig")
      local ensure_installed = vim.tbl_keys(Util.lsp.servers or {})
      vim.list_extend(ensure_installed, opts.ensure_installed)
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        auto_update = true,
        start_delay = 5000,
        debounce_hours = 5,
      })
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
