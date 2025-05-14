return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>Ss", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>SS", function() require("persistence").select() end, desc = "Select Session" },
    { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>Sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}
