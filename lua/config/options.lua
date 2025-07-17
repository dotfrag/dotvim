-- Plugin options
vim.g.folds = "origami" -- ufo or origami
vim.g.pairs = "autopairs" -- minipairs, autopairs or blinkpairs
vim.g.picker = "snacks" -- fzf or snacks
vim.g.prettier_tool = "prettierd" -- prettier or prettierd
vim.g.statusline = "lualine" -- lualine or heirline

local opt = vim.o

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = "unnamedplus"
  -- only set clipboard if not in ssh, to make sure the OSC 52 integration works automatically
  -- opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)

opt.autowrite = true -- Enable auto write
opt.breakindent = true -- Visually indent wrapped lines
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Show which line your cursor is on
opt.exrc = true -- Enable project-local configuration (.nvim.lua)
opt.grepformat = "%f:%l:%c:%m" -- Set grep format
opt.grepprg = "rg --vimgrep" -- Use ripgrep as grepprg
opt.ignorecase = true -- Case-insensitive searching unless \C
opt.inccommand = "split" -- Preview substitutions live, as you type!
opt.laststatus = 3 -- Global statusline
opt.list = true -- Display whitespace characters
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Show line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 10 -- Lines of context
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize" -- Changes the effect of the `:mksession` command
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Don't show the mode, since it's already in the status line
opt.sidescrolloff = 10 -- Columns of context
opt.signcolumn = "yes" -- Keep signcolumn on by default to prevent text shifting
opt.smartcase = true -- Case-insensitive unless one or more capital letters
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Decrease mapped sequence and which-key wait time
opt.title = true -- Set window title
opt.undofile = true -- Save undo history
opt.updatetime = 250 -- Swap file update time
opt.wrap = false -- Disable line wrap
vim.opt.diffopt:append("iwhite") -- Ignore whitespace in diff mode
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Strings to use in list mode

-- Fold settings for ufo plugin.
-- They need to be defined here instead of inside the plugin config because it causes issues with neotree.
if vim.g.folds == "ufo" then
  opt.foldcolumn = "0" -- 0 or 1
  opt.foldlevel = 99
  opt.foldlevelstart = 99
  opt.foldenable = true
end

-- Filetype mappings
vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
  filename = {
    [".ignore"] = "gitignore",
  },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/kitty/.+%.conf"] = "kitty",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
vim.treesitter.language.register("bash", "kitty")

-- Neovide options
if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true
end
