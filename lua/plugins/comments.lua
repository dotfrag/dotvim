return {
  {
    "folke/ts-comments.nvim",
    event = "LazyFile",
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    opts = {},
  },

  {
    "danymat/neogen",
    event = "LazyFile",
    opts = {},
  },

  {
    "LudoPinelli/comment-box.nvim",
    event = "LazyFile",
    keys = {
      { "<leader>cbb", "<cmd>CBccbox<cr>", desc = "Box" },
      { "<leader>cbl", "<cmd>CBlrline<cr>", desc = "Line" },
      { "<leader>cbL", "<cmd>CBline<cr>", desc = "Line Break" },
      { "<leader>cbd", "<cmd>CBd<cr>", desc = "Delete" },
    },
  },
}
