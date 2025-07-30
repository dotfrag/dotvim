if vim.g.dashboard ~= "dashboard" then
  return
end

vim.pack.add({ "https://github.com/nvimdev/dashboard-nvim" })

local header_logo = false

-- stylua: ignore
local items = {
  { icon = "  ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
  { icon = "  ", key = "n", desc = "New File", action = ":ene | startinsert" },
  { icon = "  ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
  { icon = "  ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
  { icon = "  ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('grep')" },
  { icon = "  ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
  { icon = "  ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
  { icon = "  ", key = "C", desc = "Config (grep)", action = ":lua Snacks.dashboard.pick('grep', {cwd = vim.fn.stdpath('config')})" },
  { icon = "  ", key = "d", desc = "Dotfiles", action = ":lua Snacks.dashboard.pick('files', {dirs = {'~/repos/dotfiles', '~/repos/dotfiles-private'}})" },
  { icon = "  ", key = "D", desc = "Dotfiles (grep)", action = ":lua Snacks.dashboard.pick('grep', {dirs = {'~/repos/dotfiles', '~/repos/dotfiles-private'}})" },
  { icon = "󰁯  ", key = "s", desc = "Restore Session", action = function() require("persistence").load() end },
  { icon = "󰦛  ", key = "S", desc = "Restore Last Session", action = function() require("persistence").load({ last = true }) end },
  { icon = "󰏗  ", key = "l", desc = "Packages", action = ":lua vim.pack.update()" },
  { icon = "  ", key = "q", desc = "Quit", action = ":qa" },
}

for _, i in ipairs(items) do
  i.desc = i.desc .. string.rep(" ", 42 - #i.desc) -- space desc and key out
  i.key_format = " %s" -- remove default surrounding `[]`
end

local header
if header_logo then
  local logo = Util.header()
  local win_height = vim.api.nvim_win_get_height(0) + 2 -- plus 2 for status bar
  local _, logo_count = string.gsub(logo, "\n", "") -- count newlines in logo
  local logo_height = logo_count + 3 -- logo size + newlines
  local actions_height = #items * 2 - 1 -- minus 1 for last item
  local total_height = logo_height + actions_height + 2 -- plus for 2 for footer
  local margin = math.floor((win_height - total_height) / 2)
  header = string.rep("\n", margin) .. logo .. "\n\n"
  header = vim.split(header, "\n")
else
  local win_height = vim.api.nvim_win_get_height(0) + 2 -- plus 2 for status bar
  local actions_height = #items * 2
  local margin = math.floor((win_height - actions_height) / 2)
  header = string.rep("\n", margin)
  header = vim.split(header, "\n")
end

require("dashboard").setup({
  theme = "doom",
  config = {
    header = header,
    center = items,
    footer = {},
  },
})
