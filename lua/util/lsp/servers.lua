---@class util.lsp.servers
return {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { "missing-fields" } },
      },
    },
  },

  bashls = {},

  gopls = {},

  pyright = {},
  ruff = {
    keys = {
      {
        "<leader>co",
        -- function()
        --   vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
        -- end,
        "source.organizeImports",
        "Organize Imports",
      },
    },
  },

  biome = {
    filetypes = {
      "javascript",
      "json",
      "jsonc",
      "typescript",
    },
  },

  vtsls = {},

  jsonls = {},

  taplo = {},
}
