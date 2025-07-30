require("mini.align").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("plugins.mini.ai")
require("plugins.mini.pick")

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

vim.keymap.set("n", "<leader>cj", function()
  require("mini.splitjoin").toggle()
end)

-- -- Bufremove
-- require("mini.bufremove").setup()
-- vim.keymap.set("n", "<leader>d", function()
--   require("mini.bufremove").delete()
-- end)
--
-- vim.keymap.set("n", "<leader>ba", function()
--   for _ in ipairs(vim.api.nvim_list_bufs()) do
--     require("mini.bufremove").delete() -- maybe need i?
--   end
-- end)
--
-- vim.keymap.set("n", "<leader>bo", function()
--   local cur_buf = vim.api.nvim_get_current_buf()
--   for i in ipairs(vim.api.nvim_list_bufs()) do
--     if i ~= cur_buf then
--       require("mini.bufremove").delete(i)
--     end
--   end
-- end)
