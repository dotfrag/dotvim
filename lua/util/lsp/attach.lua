---@class util.lsp.attach
return function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("dotvim_lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("<leader>cr", vim.lsp.buf.rename, "Rename")
      map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
      map("<C-h>", vim.lsp.buf.signature_help, "Show Signature Help", "i")

      -- map("gd", vim.lsp.buf.definition, "Goto Definition")
      -- map("gD", vim.lsp.buf.declaration, "Goto Declaration")
      -- map("gR", vim.lsp.buf.references, "Goto References")
      -- map("gI", vim.lsp.buf.implementation, "Goto Implementation")
      -- map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
      -- map("ss", require("telescope.builtin").lsp_document_symbols, "LSP Symbols")
      -- map("sS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "LSP Workspace Symbols")

      if vim.g.picker == "fzf" then
        map("gd", "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>", "Goto Definition")
        map("gD", "<cmd>FzfLua lsp_declarations jump1=true ignore_current_line=true<cr>", "Goto Definition")
        map("gR", "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>", "Goto References")
        map("gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", "Goto Implementation")
        map("gy", "<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>", "Goto T[y]pe Definition")
        vim.keymap.set("n", "<leader>ss", function()
          require("fzf-lua").lsp_document_symbols({ regex_filter = Util.lsp.symbols.filter })
        end, { desc = "LSP Symbols" })
        vim.keymap.set("n", "<leader>sS", function()
          require("fzf-lua").lsp_live_workspace_symbols({ regex_filter = Util.lsp.symbols.filter })
        end, { desc = "LSP Workspace Symbols" })
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- -- The following two autocommands are used to highlight references of the
      -- -- word under your cursor when your cursor rests there for a little while.
      -- -- (using snacks.word instead)
      -- if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
      if client and Util.lsp.servers[client.name] and Util.lsp.servers[client.name].keys then
        for _, v in pairs(Util.lsp.servers[client.name].keys) do
          map(v[1], function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { v[2] }, diagnostics = {} } })
          end, v[3])
        end
      end

      -- -- Inlay hints (currently using snacks for this)
      -- if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      --   map("<leader>th", function()
      --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      --   end, "Toggle Inlay Hints")
      -- end
    end,
  })
end
