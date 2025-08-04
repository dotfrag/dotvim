---@class util.lsp
---@field attach util.lsp.attach
---@field diagnostic util.lsp.diagnostic
---@field servers util.lsp.servers
---@field symbols util.lsp.symbols
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util.lsp." .. k)
    return t[k]
  end,
})

return M
