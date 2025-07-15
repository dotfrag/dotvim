---@diagnostic disable-next-line: unused-local
local border_cmp = {
  { "󱐋", "WarningMsg" },
  { "─", "Comment" },
  { "╮", "Comment" },
  { "│", "Comment" },
  { "╯", "Comment" },
  { "─", "Comment" },
  { "╰", "Comment" },
  { "│", "Comment" },
}

---@diagnostic disable-next-line: unused-local
local border_doc = {
  { "", "DiagnosticHint" },
  { "─", "Comment" },
  { "╮", "Comment" },
  { "│", "Comment" },
  { "╯", "Comment" },
  { "─", "Comment" },
  { "╰", "Comment" },
  { "│", "Comment" },
}

return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = "default",
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500,
        -- window = { border = border_doc },
      },
      -- menu = { border = border_cmp },
    },

    sources = {
      default = { "lsp", "path", "snippets", "lazydev", "buffer" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        buffer = { -- https://github.com/nvim-lua/kickstart.nvim/pull/1642
          score_offset = -100,
          enabled = function()
            local enabled_filetypes = { "markdown", "text" }
            local filetype = vim.bo.filetype
            return vim.tbl_contains(enabled_filetypes, filetype)
          end,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
