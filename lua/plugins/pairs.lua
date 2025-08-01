return {
  {
    "echasnovski/mini.pairs",
    enabled = vim.g.pairs == "mini",
    event = "LazyFile",
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    enabled = vim.g.pairs == "autopairs",
    event = "InsertEnter",
    -- examples: https://github.com/mcauley-penney/nvim/blob/d1e11271246b55461a61c9f860e6843ff5a7a438/lua/plugins/autopairs.lua
    opts = {},
  },

  {
    "saghen/blink.pairs",
    enabled = vim.g.pairs == "blinkpairs",
    event = "InsertEnter",
    version = "*", -- (recommended) only required with prebuilt binaries

    -- download prebuilt binaries from github releases
    -- dependencies = "saghen/blink.download",
    -- OR build from source
    build = "cargo build --release",
    -- OR build from source with nix
    -- build = "nix build .#build-plugin",

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
        enabled = true,
        -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
        pairs = {},
      },
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsOrange",
          "BlinkPairsPurple",
          "BlinkPairsBlue",
        },
        matchparen = {
          enabled = true,
          group = "MatchParen",
        },
      },
      debug = false,
    },
  },
}
