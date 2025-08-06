require("guess-indent").setup({})
require("nvim-surround").setup()

if vim.g.pairs == "autopairs" then
  require("nvim-autopairs").setup()
end

-- or https://github.com/ggandor/leap.nvim
---@type Flash.Config
require("flash").setup({ modes = { char = { enabled = false } } })
-- stylua: ignore start
vim.keymap.set({ "n", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
-- stylua: ignore end

vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)

if vim.g.folds == "origami" then
  require("origami").setup()
end

---@diagnostic disable-next-line: missing-fields
require("recorder").setup({
  ---@diagnostic disable-next-line: missing-fields
  mapping = {
    addBreakPoint = "||",
  },
})

require("rip-substitute").setup()
vim.keymap.set({ "n", "x" }, "<localleader>s", function()
  require("rip-substitute").sub()
end)

require("neogen").setup()
