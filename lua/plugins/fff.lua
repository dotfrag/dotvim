-- vim.g.fff = {
--   lazy_sync = true,
--   debug = { enabled = true, show_scores = true },
-- }

local fff = require("fff")

fff.setup({
  lazy_sync = true,
  debug = { enabled = false, show_scores = true },
  keymaps = {
    move_up = { "<Up>", "<C-p>", "<C-k>" },
    move_down = { "<Down>", "<C-n>", "<C-j>" },
  },
})

vim.keymap.set("n", "<leader>ff", function()
  fff.find_files()
end, { desc = "FFFind files" })
