require("bufferline").setup({
  options = {
    always_show_bufferline = false,
    close_command = function(n)
      require("mini.bufremove").delete(n)
    end,
    right_mouse_command = function(n)
      require("mini.bufremove").delete(n)
    end,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "snacks_layout_box",
      },
    },
  },
})

vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
vim.keymap.set("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<C-,>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer Left" })
vim.keymap.set("n", "<C-.>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Right" })
