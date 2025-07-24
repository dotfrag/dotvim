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
