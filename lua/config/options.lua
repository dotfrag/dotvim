-- Plugin options
vim.g.dashboard = "snacks" -- dashboard | snacks
vim.g.explorer = "snacks" -- neo-tree | snacks
vim.g.folds = "origami" -- ufo | origami
vim.g.pairs = "autopairs" -- minipairs | autopairs | blinkpairs
vim.g.picker = "snacks" -- fzf | mini | snacks
vim.g.prettier_tool = "prettierd" -- prettier | prettierd

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

-- o.laststatus = 3 -- Global statusline
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
o.list = true -- Display whitespace characters
o.mouse = "a" -- Enable mouse mode
o.number = true -- Show line number
o.relativenumber = true -- Relative line numbers
o.scrolloff = 10 -- Lines of context
o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize" -- Changes the effect of the `:mksession` command
o.shiftwidth = 2 -- Size of an indent
o.shortmess = "I" -- Disable intro message
o.showmode = false -- Don't show the mode, since it's already in the status line
o.sidescrolloff = 10 -- Columns of context
o.signcolumn = "yes" -- Keep signcolumn on by default to prevent text shifting
o.smartcase = true -- Case-insensitive unless one or more capital letters
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.tabstop = 2 -- Number of spaces tabs count for
o.termguicolors = true -- True color support
o.timeout = false -- Fix leader key timeout
o.timeoutlen = 300 -- Decrease mapped sequence and which-key wait time
o.title = true -- Set window title
o.ttimeout = true -- Fix leader key timeout
o.undofile = true -- Save undo history
o.updatetime = 250 -- Swap file update time
o.winborder = "single" -- Border style of floating windows
o.wrap = false -- Disable line wrap
vim.opt.diffopt:append("iwhite") -- Ignore whitespace in diff mode
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Strings to use in list mode

-- Fold settings
if vim.g.folds == "origami" then
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
end

-- Filetype mappings
vim.filetype.add({
  extension = {
    ["http"] = "http",
    ["mdx"] = "markdown.mdx",
  },
  filename = {
    [".ignore"] = "gitignore",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
    [".*/hypr/.+%.conf"] = "hyprlang",
    [".*/kitty/.+%.conf"] = "kitty",
    [".*/waybar/config"] = "jsonc",
  },
})
vim.treesitter.language.register("bash", { "kitty", "zsh" })

-- Neovide options
if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true
end
