---@class util
---@field diagnostic util.diagnostic
---@field mason util.mason
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util." .. k)
    return t[k]
  end,
})

-- https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/util/init.lua#L118-L126
---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").spec.plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

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

return M
