return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      -- signs = {
      --   add = { text = "▎" },
      --   change = { text = "▎" },
      --   delete = { text = "" },
      --   topdelete = { text = "" },
      --   changedelete = { text = "▎" },
      --   untracked = { text = "▎" },
      -- },
      -- signs_staged = {
      --   add = { text = "▎" },
      --   change = { text = "▎" },
      --   delete = { text = "" },
      --   topdelete = { text = "" },
      --   changedelete = { text = "▎" },
      -- },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hi", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hB", function() gs.blame() end, "Blame File")
        map("n", "<leader>hd", gs.diffthis, "Diff This")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
        map('n', '<leader>hQ', function() gs.setqflist("all") end, "Quickfix Hunks All")
        map('n', '<leader>hq', gs.setqflist, "Quickfix Hunks Buffer")
        map('n', '<leader>htb', gs.toggle_current_line_blame, "Current Line Blame")
        map('n', '<leader>htd', gs.toggle_deleted, "Deleted Lines")
        map('n', '<leader>htw', gs.toggle_word_diff, "Word Diff")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Git Signs",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>uG")
    end,
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      },
    },
    opts = {
      -- kind = "floating",
      -- floating = {
      --   width = 0.9,
      --   height = 0.8,
      -- },
      signs = {
        item = { "", "" },
        section = { "", "" },
      },
    },
    keys = { { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" } },
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Gclog",
      "GDelete",
      "Gdiffsplit",
      "Gedit",
      "Ggrep",
      "Git",
      "GMove",
      "Gread",
      "GRemove",
      "GRename",
      "Gsplit",
      "Gvdiffsplit",
      "Gwrite",
    },
    keys = {
      -- { "<leader>gB", "<cmd>Git blame<cr>", desc = "Blame" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Pull" },
    },
  },

  -- {
  --   "kdheepak/lazygit.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   keys = {
  --     { "<A-g>", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  --   },
  -- },
}
