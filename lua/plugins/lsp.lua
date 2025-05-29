return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
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
      -- { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {
      servers = {
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
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("dotvim_lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

          -- the following are defined in snacks.lua
          -- map("gd", vim.lsp.buf.definition, "Goto Definition")
          -- map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          -- map("gr", vim.lsp.buf.references, "Goto References")
          -- map("gI", vim.lsp.buf.implementation, "Goto Implementation")
          -- map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
          -- map("ss", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
          -- map("sS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- map("gd", "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>", "Goto Definition")
          -- map("gr", "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>", "Goto References")
          -- map("gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", "Goto Implementation")
          -- map("gy", "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>", "Goto T[y]pe Definition")
          -- map("<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", "Symbols")
          -- map("<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", "Symbols (Workspace)")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              ---@diagnostic disable-next-line: param-type-mismatch
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- -- The following two autocommands are used to highlight references of the
          -- -- word under your cursor when your cursor rests there for a little while.
          -- -- (using snacks.word instead)
          -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          --   local highlight_augroup = vim.api.nvim_create_augroup("dotvim_lsp-highlight", { clear = false })
          --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          --     buffer = event.buf,
          --     group = highlight_augroup,
          --     callback = vim.lsp.buf.document_highlight,
          --   })
          --
          --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          --     buffer = event.buf,
          --     group = highlight_augroup,
          --     callback = vim.lsp.buf.clear_references,
          --   })
          --
          --   vim.api.nvim_create_autocmd("LspDetach", {
          --     group = vim.api.nvim_create_augroup("dotvim_lsp-detach", { clear = true }),
          --     callback = function(event2)
          --       vim.lsp.buf.clear_references()
          --       vim.api.nvim_clear_autocmds({ group = "dotvim_lsp-highlight", buffer = event2.buf })
          --     end,
          --   })
          -- end

          -- Language specific keymaps
          if client and opts.servers[client.name] and opts.servers[client.name].keys then
            for _, v in pairs(opts.servers[client.name].keys) do
              map(v[1], function()
                vim.lsp.buf.code_action({ apply = true, context = { only = { v[2] }, diagnostics = {} } })
              end, v[3])
            end
          end

          -- -- Inlay hints (currently using snacks for this)
          -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          --   map("<leader>th", function()
          --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          --   end, "Toggle Inlay Hints")
          -- end
        end,
      })

      -- Diagnostics
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          -- prefix = "",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      -- LSP setup
      -- require("mason-lspconfig").setup({
      --   ensure_installed = {}, -- explicitly set to an empty table (populate installs via mason-tool-installer)
      --   handlers = {
      --     function(server_name)
      --       local config = opts.servers[server_name] or {}
      --       vim.lsp.config(server_name, config)
      --       vim.lsp.enable(server_name)
      --     end,
      --   },
      -- })

      -- Extend capabilities
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for server, config in pairs(opts.servers) do
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
      local ensure_installed = vim.tbl_keys(opts.servers or {})
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
