---@class util.text
local M = {}

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

function M.comment_line()
  local cs = (require("ts-comments.comments").get(vim.bo.filetype) or vim.bo.commentstring):gsub("%%s", "")
  local text = vim.api.nvim_get_current_line():gsub("-+ ", ""):gsub(cs, "")
  -- using `#text - #cs` instead of `#line` for lines without comment
  local dashes = string.rep("-", 80 - #text - #cs - 1)
  vim.api.nvim_set_current_line(cs .. dashes .. " " .. text)
end

function M.virtualedit()
  if vim.o.virtualedit == "" then
    vim.o.virtualedit = "all"
    vim.notify("Enabled Virtual Edit", vim.log.levels.INFO)
  else
    vim.o.virtualedit = ""
    vim.notify("Disabled Virtual Edit", vim.log.levels.WARN)
  end
end

return M
