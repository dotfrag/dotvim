-- Plugin options
vim.g.folds = "origami" -- ufo or origami
vim.g.pairs = "autopairs" -- minipairs, autopairs or blinkpairs
vim.g.picker = "snacks" -- fzf or snacks
vim.g.prettier_tool = "prettierd" -- prettier or prettierd
vim.g.statusline = "lualine" -- lualine or heirline
vim.g.treesitter_new = true -- true (main) or false (master)

local o = vim.o

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = "unnamedplus"
  -- only set clipboard if not in ssh, to make sure the OSC 52 integration works automatically
  -- opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)

o.autowrite = true -- Enable auto write
o.breakindent = true -- Visually indent wrapped lines
o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = true -- Show which line your cursor is on
o.exrc = true -- Enable project-local configuration (.nvim.lua)
o.grepformat = "%f:%l:%c:%m" -- Set grep format
o.grepprg = "rg --vimgrep" -- Use ripgrep as grepprg
o.ignorecase = true -- Case-insensitive searching unless \C
o.inccommand = "split" -- Preview substitutions live, as you type!
o.laststatus = 3 -- Global statusline
o.list = true -- Display whitespace characters
o.mouse = "a" -- Enable mouse mode
o.number = true -- Show line number
o.relativenumber = true -- Relative line numbers
o.scrolloff = 10 -- Lines of context
o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize" -- Changes the effect of the `:mksession` command
o.shiftwidth = 2 -- Size of an indent
o.showmode = false -- Don't show the mode, since it's already in the status line
o.sidescrolloff = 10 -- Columns of context
o.signcolumn = "yes" -- Keep signcolumn on by default to prevent text shifting
o.smartcase = true -- Case-insensitive unless one or more capital letters
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.tabstop = 2 -- Number of spaces tabs count for
o.termguicolors = true -- True color support
o.timeoutlen = 300 -- Decrease mapped sequence and which-key wait time
o.title = true -- Set window title
o.undofile = true -- Save undo history
o.updatetime = 250 -- Swap file update time
o.wrap = false -- Disable line wrap
vim.opt.diffopt:append("iwhite") -- Ignore whitespace in diff mode
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Strings to use in list mode

-- Fold settings for ufo plugin.
-- They need to be defined here instead of inside the plugin config because it causes issues with neotree.
if vim.g.folds == "ufo" then
  o.foldcolumn = "0" -- 0 or 1
  o.foldlevel = 99
  o.foldlevelstart = 99
  o.foldenable = true
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
