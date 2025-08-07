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

  basedpyright = {},
  ruff = {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = { settings = { logLevel = "error" } },
    keys = { { "<leader>co", "source.organizeImports", "Organize Imports" } },
    -- disable hover in favor of pyright
    -- on_attach = function(client)
    --   client.server_capabilities.hoverProvider = false
    -- end,
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

  taplo = {},

  jsonls = {
    -- lazy-load schemastore when needed
    on_init = function(client)
      client.settings.json.schemas = client.settings.json.schemas or {}
      vim.list_extend(client.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
      json = {
        -- format = { enable = true },
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    -- have to add this for yamlls to understand that we support line folding
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    -- lazy-load schemastore when needed
    on_init = function(client)
      client.settings.yaml.schemas = vim.tbl_deep_extend("force", client.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
    end,
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = {
          enable = true,
        },
        validate = true,
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
      },
    },
  },
}
