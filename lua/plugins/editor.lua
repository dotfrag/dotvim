require("guess-indent").setup({})
require("nvim-surround").setup()

if vim.g.pairs == "autopairs" then
  require("nvim-autopairs").setup()
end

-- or https://github.com/ggandor/leap.nvim
---@type Flash.Config
require("flash").setup()
-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
-- stylua: ignore end

vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
