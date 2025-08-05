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
        -- Support for global vim object
        -- workspace = {
        --   library = {
        --     vim.api.nvim_get_runtime_file("", true),
        --   },
        -- },
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
  emmet_language_server = {},

  vtsls = {},

  jsonls = {},

  taplo = {},
}
