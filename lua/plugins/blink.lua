local cmp = require("blink.cmp")
cmp.build():wait(60000)

---@module 'blink.cmp'
---@type blink.cmp.Config
cmp.setup({
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = { preset = "default" },

  completion = {
    documentation = { auto_show = true },
    menu = { scrollbar = false },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      -- lsp = { fallbacks = {} }, -- defaults to `{ 'buffer' }` (to always show the buffer source)
      lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      buffer = { -- https://github.com/nvim-lua/kickstart.nvim/pull/1642
        score_offset = -100,
        -- enabled = function()
        --   local enabled_filetypes = { "markdown", "text" }
        --   local filetype = vim.bo.filetype
        --   return vim.tbl_contains(enabled_filetypes, filetype)
        -- end,
      },
    },
  },

  -- Command line completion
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<Right>"] = false,
      ["<Left>"] = false,
    },
    completion = {
      list = { selection = { preselect = false } },
      menu = {
        auto_show = function(_)
          return vim.fn.getcmdtype() == ":"
        end,
      },
      ghost_text = { enabled = true },
    },
  },

  -- Shows a signature help window while you type arguments for a function
  signature = {
    enabled = true,
    -- window = {
    --   show_documentation = true,
    -- },
  },

  -- Rust fuzzy matcher for typo resistance and significantly better performance
  fuzzy = { implementation = "rust" },
})
