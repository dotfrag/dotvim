---@diagnostic disable: missing-fields

local map = vim.keymap.set

-- Quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Save buffer
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Save buffer without formatting
map("n", "<leader>W", "<cmd>noautocmd w<cr>", { desc = "Save Without Formatting" })

-- Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr>")
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Navigate command-line history
map("c", "<C-j>", "<Down>", { desc = "Next Command" })
map("c", "<C-k>", "<Up>", { desc = "Previous Command" })

-- Center view in insert mode
map("i", "zz", "<C-o>zz")

-- Insert text in insert mode
map("i", "II", "<C-o>I")

-- Append text in insert mode
map("i", "AA", "<C-o>A")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map("n", "<leader>ur", "<cmd>nohlsearch|diffupdate|normal! <C-l><cr>", { desc = "Redraw / Clear hlsearch / Diff Update" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>-", "<C-w>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-w>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window width" })

-- stylua: ignore start

-- Terminal
map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Terminal" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Buffers
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>d", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>ba", function() Snacks.bufdelete.all() end, { desc = "Delete All Buffers" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
map("n", "<leader>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- stylua: ignore end

-- Quickfix
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
-- map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
-- map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Saner behavior of n and N
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Inspect
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Regex
map("n", "<leader>ra", "/[^\\x00-\\x7F]<cr>", { desc = "Find Non-ASCII Characters" })
map("n", "<leader>rb", "<cmd>s/ /\\r/g<cr>|<cmd>noh<cr>", { desc = "Break Line" })
map("n", "<leader>rc", "<cmd>%s/[[:cntrl:]]//<cr>``", { desc = "Remove Control Symbols" })
-- also: https://github.com/mcauley-penney/tidy.nvim
map("n", "<leader>re", "<cmd>g/^$/d<cr>|<cmd>noh<cr>", { desc = "Delete Empty Lines" })
-- map("n", "<leader>rE", "<cmd>%!cat -s<cr>", { desc = "Delete Multiple Empty Lines" })
map("n", "<leader>rE", [[:%s!\n\n\n\+!\r\r!g<cr>|<cmd>noh<cr>]], { desc = "Delete Multiple Empty Lines" })
map("n", "<leader>rp", "<cmd>%s/[^[:print:]]//<cr>|<cmd>noh<cr>``", { desc = "Remove Non-Printable Characters" })
map("n", "<leader>rt", "<cmd>%s/\\s\\+$//<cr>|<cmd>noh<cr>``", { desc = "Remove Trailing Whitespace" }) -- alternative: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })
-- stylua: ignore start
map("n", "<leader>rm", function() Util.modeline() end, { desc = "Append Modeline", noremap = true, silent = true })
map("n", "<leader>rM", function() Util.modeline(true) end, { desc = "Append Modeline (Long Format)", noremap = true, silent = true })
-- stylua: ignore end

-- Neovide copy/paste
-- https://github.com/neovide/neovide/issues/1282#issuecomment-1980984696
if vim.g.neovide then
  map("v", "<CS-c>", '"+y') -- Copy
  map("n", "<CS-v>", '"+P') -- Paste normal mode
  map("v", "<CS-v>", '"+P') -- Paste visual mode
  map("c", "<CS-v>", "<C-R>+") -- Paste command mode
  map("i", "<CS-v>", "<C-R>+") -- Paste insert mode
  map("t", "<CS-v>", '<C-\\><C-o>"+p') -- Paste terminal mode
end
