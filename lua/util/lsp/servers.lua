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

  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
    -- workaround for gopls not supporting semanticTokensProvider
    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
    on_attach = function(client)
      if not client.server_capabilities.semanticTokensProvider then
        local semantic = client.config.capabilities.textDocument.semanticTokens
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = { tokenTypes = semantic.tokenTypes, tokenModifiers = semantic.tokenModifiers },
          range = true,
        }
      end
    end,
  },

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
