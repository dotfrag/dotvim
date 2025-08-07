local sql_formatter_opts = {
  keywordCase = "upper",
  dataTypeCase = "upper",
  functionCase = "upper",
  expressionWidth = 80,
}

require("conform").setup({
  notify_on_error = false,
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#autoformat-with-extra-features
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
  formatters = {
    shfmt = { prepend_args = { "--simplify", "--indent", "2", "--binary-next-line", "--case-indent", "--space-redirects" } },
    sql_formatter = { prepend_args = { "--config", vim.json.encode(sql_formatter_opts) } },
  },
  formatters_by_ft = {
    -- lua and shell
    lua = { "stylua" },
    sh = { "shfmt", "shellcheck" },

    -- prettier
    html = { vim.g.prettier_tool },
    css = { vim.g.prettier_tool },
    scss = { vim.g.prettier_tool },
    less = { vim.g.prettier_tool },
    yaml = { vim.g.prettier_tool },
    markdown = { vim.g.prettier_tool },
    ["markdown.mdx"] = { "prettierd" },

    -- biome
    javascript = { "biome" },
    typescript = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },

    -- other
    -- go = { "goimports", "gofumpt" },
    htmldjango = { "djlint" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    sql = { "sql_formatter" },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end)

vim.keymap.set("n", "<leader>uf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.g.disable_autoformat then
    vim.notify("Disabled Formatting", vim.log.levels.WARN, { title = "Formatting" })
  else
    vim.notify("Enabled Formatting", vim.log.levels.INFO, { title = "Formatting" })
  end
end)
