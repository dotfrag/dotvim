require("oil").setup()

if vim.fn.argc(-1) == 1 then
  ---@diagnostic disable-next-line: param-type-mismatch
  local stat = vim.uv.fs_stat(vim.fn.argv(0))
  if stat and stat.type == "directory" then
    vim.cmd("Oil")
  end
end

vim.keymap.set("n", "<leader>o", ":Oil<CR>")
