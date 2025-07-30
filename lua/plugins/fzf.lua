-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/fzf.lua

if vim.g.picker ~= "fzf" then
  return
end

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup()
require("fzf-lua").register_ui_select()

local config = vim.fn.stdpath("config")
local dotfiles = { "~/repos/dotfiles", "~/repos/dotfiles-private" }
local plugins = vim.fn.stdpath("data") .. "/site/pack/core/opt"

-- Generic
vim.keymap.set("n", "<leader>.", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>s.", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua blines<cr>", { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>:", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>uC", "<cmd>FzfLua colorschemes<cr>", { desc = "Colorscheme with Preview" })

-- Find
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua files cwd=" .. config .. "<cr>", { desc = "Config Files" })
vim.keymap.set("n", "<leader>fC", "<cmd>FzfLua live_grep cwd=" .. config .. "<cr>", { desc = "Config Files (Grep)" })
vim.keymap.set("n", "<leader>fd", function()
  require("fzf-lua").files({ search_paths = dotfiles })
end, { desc = "Dotfiles" })
vim.keymap.set("n", "<leader>fD", function()
  require("fzf-lua").live_grep({ search_paths = dotfiles })
end, { desc = "Dotfiles" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Git Files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })

-- Git
vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", "<cmd>FzfLua git_commits<cr>", { desc = "Git Log" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", "<cmd>FzfLua git_stash<cr>", { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", "<cmd>FzfLua git_diff<cr>", { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_stash<cr>", { desc = "Git Stash" })

-- LSP
vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>", { desc = "Goto Definition" })
vim.keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations jump1=true ignore_current_line=true<cr>", { desc = "Goto Definition" })
vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>", { desc = "Goto References" })
vim.keymap.set("n", "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", "<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>", { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss", function()
  require("fzf-lua").lsp_document_symbols({ regex_filter = Util.lsp.symbols.filter })
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function()
  require("fzf-lua").lsp_live_workspace_symbols({ regex_filter = Util.lsp.symbols.filter })
end, { desc = "LSP Workspace Symbols" })

-- Search
vim.keymap.set("n", "<leader>s/", "<cmd>FzfLua search_history<cr>", { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", "<cmd>FzfLua autocmds<cr>", { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua blines<cr>", { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", "<cmd>FzfLua lines<cr>", { desc = "Open Buffers Lines" })
vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>sD", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<cr>", { desc = "Files" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep" })
vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua helptags<cr>", { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", { desc = "Highlights" })
vim.keymap.set("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>", { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sp", "<cmd>FzfLua files cwd=" .. plugins .. "<cr>", { desc = "Plugin Files" })
vim.keymap.set("n", "<leader>sp", "<cmd>FzfLua live_grep cwd=" .. plugins .. "<cr>", { desc = "Plugin Files (Grep)" })
vim.keymap.set("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", '<leader>s"', "<cmd>FzfLua registers<cr>", { desc = "Registers" })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Word" })
vim.keymap.set("v", "<leader>sw", "<cmd>FzfLua grep_visual<cr>", { desc = "Visual Selection or Word" })
