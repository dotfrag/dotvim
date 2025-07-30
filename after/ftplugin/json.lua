-- simple
vim.keymap.set("n", "<leader>cq", function()
  local cur = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%!jq 'to_entries|sort|from_entries']])
  vim.api.nvim_win_set_cursor(0, cur)
end, { buffer = true, desc = "Sort JSON Keys" })

-- with error handling
vim.keymap.set("n", "<leader>cQ", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local input = table.concat(lines, "\n")
  local result = vim.fn.systemlist("jq 'to_entries|sort|from_entries'", input)
  if vim.v.shell_error ~= 0 then
    vim.notify("jq failed:\n" .. table.concat(result, "\n"), vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
end, { buffer = true, desc = "Sort JSON Keys" })
