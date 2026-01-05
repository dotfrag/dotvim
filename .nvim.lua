vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "lua/plugins/init.lua",
  callback = function()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[g/AUTOSORT: START/+1,/AUTOSORT: END/-1 sort i]])
    vim.api.nvim_win_set_cursor(0, cur)
  end,
})
