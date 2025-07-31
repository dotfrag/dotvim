require("mini.align").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("plugins.mini.ai")
require("plugins.mini.pick")

local mm = require("mini.misc")
mm.setup_auto_root()
mm.setup_restore_cursor()
mm.setup_termbg_sync()

vim.keymap.set("n", "<leader>cj", function()
  require("mini.splitjoin").toggle()
end)
