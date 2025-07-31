local lsp_servers = {
  "bashls",
  "biome",
  "emmet_ls",
  "lua_ls",
}
local mason_packages = {
  "djlint", -- django
  "shellcheck", -- bash
  "shfmt", -- bash
  "sql-formatter", -- sql
  "stylua", -- lua
  vim.g.prettier_tool, -- html
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

vim.lsp.enable(lsp_servers)

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_extend("force", lsp_servers, mason_packages),
  auto_update = true,
  run_on_start = true,
  start_delay = 5000,
  debounce_hours = 5,
})

require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
