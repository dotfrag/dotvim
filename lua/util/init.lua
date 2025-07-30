---@class util
---@field lsp util.lsp
---@field mason util.mason
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util." .. k)
    return t[k]
  end,
})

---@param long_format? boolean
function M.modeline(long_format)
  local tabstop = vim.bo.tabstop
  local shiftwidth = vim.bo.shiftwidth
  -- local textwidth = vim.bo.textwidth
  local expandtab = vim.bo.expandtab and "" or "no"

  local modeline
  if long_format then
    modeline = string.format("vim: set ts=%d sw=%d %set :", tabstop, shiftwidth, expandtab)
  else
    modeline = string.format("vim: ts=%d sw=%d %set", tabstop, shiftwidth, expandtab)
  end

  local commentstring = require("ts-comments.comments").get(vim.bo.filetype) or vim.bo.commentstring
  modeline = commentstring:gsub("%%s", modeline)

  vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", modeline })
  vim.api.nvim_feedkeys("Gzz", "n", false)
end

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
