require("persistence").setup()
-- stylua: ignore start
vim.keymap.set("n", "<leader>Ss", function() require("persistence").load() end, { desc = "Restore Session" })
vim.keymap.set("n", "<leader>SS", function() require("persistence").select() end, { desc = "Select Session" })
vim.keymap.set("n", "<leader>Sl", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set("n", "<leader>Sd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })
-- stylua: ignore end

-- https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/util.lua#L1-L9
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

---@type snacks.Config
require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = vim.g.dashboard == "snacks",
    width = 50,
    preset = {
      header = false,
      -- stylua: ignore
      ---@type snacks.dashboard.Item[]
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
        { icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
        { icon = " ", key = "C", desc = "Config (grep)", action = ":lua Snacks.dashboard.pick('grep', {cwd = vim.fn.stdpath('config')})" },
        { icon = " ", key = "d", desc = "Dotfiles", action = ":lua Snacks.dashboard.pick('files', {dirs = {'~/repos/dotfiles', '~/repos/dotfiles-private'}})" },
        { icon = " ", key = "D", desc = "Dotfiles (grep)", action = ":lua Snacks.dashboard.pick('grep', {dirs = {'~/repos/dotfiles', '~/repos/dotfiles-private'}})" },
        { icon = "󰁯 ", key = "s", desc = "Restore Session", action = function() require("persistence").load() end },
        { icon = "󰦛 ", key = "S", desc = "Restore Last Session", action = function() require("persistence").load({ last = true }) end },
        { icon = "󰏗 ", key = "l", desc = "Packages", action = ":lua vim.pack.update()" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
  },
  explorer = { enabled = vim.g.explorer == "snacks" },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  picker = { enabled = vim.g.picker == "snacks" },
  quickfile = { enabled = true },
  terminal = {
    win = {
      keys = {
        nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
        nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
        nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
        nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
      },
    },
  },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true }, -- wrap notifications
    },
  },
  words = {
    enabled = true,
    debounce = 250, -- time in ms to wait before updating
  },
})

Util.on_vim_enter(function()
  -- Setup some globals for debugging (lazy-loaded)
  _G.dd = function(...)
    Snacks.debug.inspect(...)
  end
  _G.bt = function()
    Snacks.debug.backtrace()
  end
  -- vim._print = function(_, ...)
  --   dd(...)
  -- end

  -- Create some toggle mappings
  Snacks.toggle.diagnostics():map("<leader>ud")
  Snacks.toggle.dim():map("<leader>uD")
  Snacks.toggle.indent():map("<leader>ug")
  Snacks.toggle.inlay_hints():map("<leader>uh")
  Snacks.toggle.line_number():map("<leader>ul")
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
  Snacks.toggle.option("expandtab", { name = "Expand Tab" }):map("<leader>ue")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  Snacks.toggle.treesitter():map("<leader>ut")
end)

-- stylua: ignore start

-- Buffers
vim.keymap.set("n", "<leader>d", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>ba", function() Snacks.bufdelete.all() end, { desc = "Delete All Buffers" })
vim.keymap.set("n", "<leader>z", function() Snacks.zen.zoom() end, { desc = "Delete All Buffers" })

-- Lazygit
vim.keymap.set("n", "<A-g>", function() Snacks.lazygit({ win = { width = 0, height = 0 } }) end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit({ win = { width = 0, height = 0 } }) end, { desc = "Lazygit" })

-- Words
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "next reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
vim.keymap.set({ "n", "t" }, "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev Reference" })

-- Terminal
-- vim.keymap.set("n", "<C-/>", function() Snacks.terminal() end, { desc = "Terminal" })
-- vim.keymap.set("n", "<C-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })

-- Other
vim.keymap.set("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
vim.keymap.set({"n","v"}, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })

if vim.g.picker == "snacks" then
  local config = vim.fn.stdpath("config")
  local dotfiles = { "~/repos/dotfiles", "~/repos/dotfiles-private" }
  local plugins = vim.fn.stdpath("data") .. "/site/pack/core/opt"

  -- Generic
  vim.keymap.set("n", "<leader>.", function() Snacks.picker.resume() end, { desc = "Resume" })
  vim.keymap.set("n", "<leader>s.", function() Snacks.picker.resume() end, { desc = "Resume" })
  vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
  vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
  vim.keymap.set("n", "<leader>/", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
  vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
  vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

  -- Find
  vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
  vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = config }) end, { desc = "Config Files" })
  vim.keymap.set("n", "<leader>fC", function() Snacks.picker.grep({ cwd = config }) end, { desc = "Config Files (Grep)" })
  vim.keymap.set("n", "<leader>fd", function() Snacks.picker.files({ dirs = dotfiles, hidden = true }) end, { desc = "Dotfiles" })
  vim.keymap.set("n", "<leader>fD", function() Snacks.picker.grep({ dirs = dotfiles, hidden = true }) end, { desc = "Dotfiles (Grep)" })
  vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Files" })
  vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Git Files" })
  vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })

  -- Git
  vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
  vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
  vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

  -- LSP
  vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
  vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
  vim.keymap.set("n", "gR", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "Goto References" })
  vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
  vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
  vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
  vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

  -- Search
  vim.keymap.set("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
  vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Auto Commands" })
  vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
  vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
  vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
  vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
  vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
  vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
  vim.keymap.set("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Files" })
  vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
  vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
  vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
  vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
  vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
  vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
  vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
  vim.keymap.set("n", "<leader>sp", function() Snacks.picker.files({ cwd = plugins }) end, { desc = "Plugin Files" })
  vim.keymap.set("n", "<leader>sP", function() Snacks.picker.grep({ cwd = plugins }) end, { desc = "Plugin Files (Grep)" })
  vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
  vim.keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
  vim.keymap.set({"n",'x'}, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual Selection or Word"  })
end

-- not available in other pickers:
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })

-- stylua: ignore end

if vim.g.explorer == "snacks" then
  vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
  end, { desc = "File Explorer" })
end
