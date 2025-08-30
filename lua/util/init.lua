---@class util
---@field lsp util.lsp
---@field mason util.mason
---@field text util.text
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util." .. k)
    return t[k]
  end,
})

---@param fn fun()
function M.on_vim_enter(fn)
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      fn()
    end,
  })
end

---@overload fun(fn: fun())
---@param arg any
function M.late(arg)
  M.on_vim_enter(function()
    vim.schedule(function()
      if type(arg) == "function" then
        arg()
      else
        vim.print(arg)
      end
    end)
  end)
end

---@return string
function M.header()
  local header
  if vim.g.neovide then
    header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗  
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝  
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝
    ]]
  else
    header = [[
    ██████╗  ██████╗ ████████╗██╗   ██╗██╗███╗   ███╗
    ██╔══██╗██╔═══██╗╚══██╔══╝██║   ██║██║████╗ ████║
    ██║  ██║██║   ██║   ██║   ██║   ██║██║██╔████╔██║
    ██║  ██║██║   ██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
    ██████╔╝╚██████╔╝   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═════╝  ╚═════╝    ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]
  end
  return header
end

return M
