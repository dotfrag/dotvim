local mason_packages = {
  "djlint", -- django
  "shellcheck", -- bash
  "shfmt", -- bash
  "sql-formatter", -- sql
  "stylua", -- lua
  vim.g.prettier_tool, -- html
}

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client and client:supports_method("textDocument/completion") then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
-- vim.cmd("set completeopt+=noselect")

Util.lsp.attach()
Util.lsp.diagnostic.setup("tiny")

require("plugins.blink")
local capabilities = require("blink.cmp").get_lsp_capabilities()
for server, config in pairs(Util.lsp.servers) do
  config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
  vim.lsp.config(server, config)
  -- vim.lsp.enable(server)
end

local lsp_servers = vim.tbl_keys(Util.lsp.servers)
vim.lsp.enable(lsp_servers)

vim.keymap.set("n", "<leader>cl", vim.cmd.LspInfo)
vim.keymap.set("n", "<leader>cm", vim.cmd.Mason)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

require("mason").setup()
require("mason-lspconfig").setup({ automatic_enable = false })
require("mason-tool-installer").setup({
  ensure_installed = vim.list_extend(lsp_servers, mason_packages),
  auto_update = true,
  run_on_start = true,
  start_delay = 5000,
  debounce_hours = 5,
})
