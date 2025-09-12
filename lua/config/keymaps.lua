local map = vim.keymap.set

-- Quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Save buffer
map("n", "<leader>w", "<cmd>write<cr>")
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Save buffer without formatting
map("n", "<leader>W", "<cmd>noautocmd w<cr>", { desc = "Save Without Formatting" })

-- Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr>")
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Put on new line
map("n", "]p", "o<esc>p==^", { desc = "Put Indented After Cursor (linewise)" })
map("n", "[p", "O<esc>p==^", { desc = "Put Indented After Cursor (linewise)" })

-- -- Clipboard
-- vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<cr>')
-- vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<cr>')

-- Navigate command-line history
map("c", "<C-j>", "<Down>", { desc = "Next Command" })
map("c", "<C-k>", "<Up>", { desc = "Previous Command" })

-- Center view in insert mode
map("i", "zz", "<C-o>zz")

-- Insert text in insert mode
map("i", "II", "<C-o>I")

-- Append text in insert mode
map("i", "AA", "<C-o>A")

-- Comment and duplicate current line
map("n", "<localleader>d", function()
  vim.cmd.normal("yygccp")
end)

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map("n", "<leader>ur", "<cmd>nohlsearch|diffupdate|normal! <C-l><cr>", { desc = "Redraw / Clear hlsearch / Diff Update" })

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

-- Terminal
map("n", "<C-/>", function()
  vim.system({ "kitty", "--directory", vim.fn.getcwd() })
end)
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<C-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Folds (conflicts with Ctrl-I)
-- map("n", "<Tab>", "za", { desc = "Toggle Fold" })

-- stylua: ignore start

-- Buffers
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>D", "<cmd>bd<cr>", { desc = "Delete Buffer and Window" })

-- stylua: ignore end

-- Quickfix
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

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
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Inspect
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Comment line
map("n", "<localleader>c", Util.text.comment_line, { desc = "Comment line" })

-- Toggle virtualedit
map("n", "<leader>uv", Util.text.virtualedit)

-- Regex
map("n", "<leader>ra", "/[^\\x00-\\x7F]<cr>", { desc = "Find Non-ASCII Characters" })
map("n", "<leader>rb", "<cmd>s/ /\\r/g<cr>|<cmd>noh<cr>", { desc = "Break Line" })
map("n", "<leader>rc", "<cmd>%s/[[:cntrl:]]//<cr>``", { desc = "Remove Control Symbols" })
-- also: https://github.com/mcauley-penney/tidy.nvim
map("n", "<leader>re", "<cmd>g/^$/d<cr>|<cmd>noh<cr>", { desc = "Delete Empty Lines" })
-- map("n", "<leader>rE", "<cmd>%!cat -s<cr>", { desc = "Delete Multiple Empty Lines" })
map("n", "<leader>rE", [[:%s!\n\n\n\+!\r\r!g<cr>|<cmd>noh<cr>]], { desc = "Delete Multiple Empty Lines" })
map("n", "<leader>rp", "<cmd>%s/[^[:print:]]//<cr>|<cmd>noh<cr>``", { desc = "Remove Non-Printable Characters" })
map("n", "<leader>rt", "<cmd>%s/\\s\\+$//<cr>|<cmd>noh<cr>``", { desc = "Remove Trailing Whitespace" }) -- alternative: https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-trailspace.md
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })
-- stylua: ignore start
map("n", "<leader>rm", function() Util.text.modeline() end, { desc = "Append Modeline", noremap = true, silent = true })
map("n", "<leader>rM", function() Util.text.modeline(true) end, { desc = "Append Modeline (Long Format)", noremap = true, silent = true })
-- stylua: ignore end

-- Everything is magic
local verymagic = true
if verymagic then
  -- Normal mode search
  vim.keymap.set("n", "/", "/\\v")
  vim.keymap.set("n", "?", "?\\v")

  -- Substitute
  vim.keymap.set("c", "s/", "s/\\v")
  vim.keymap.set("c", "%s/", "%s/\\v")

  -- Global commands
  vim.keymap.set("c", "g/", "g/\\v")
  vim.keymap.set("c", "v/", "v/\\v")
end

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
