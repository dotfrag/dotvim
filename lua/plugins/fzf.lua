-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/fzf.lua
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/init.lua

if vim.g.picker ~= "fzf" then
  return
end

---@type table<string, string[]|boolean>?
local kind_filter = {
  default = {
    "Class",
    "Constructor",
    "Enum",
    "Field",
    "Function",
    "Interface",
    "Method",
    "Module",
    "Namespace",
    "Package",
    "Property",
    "Struct",
    "Trait",
  },
  markdown = false,
  help = false,
  -- you can specify a different filter for each filetype
  lua = {
    "Class",
    "Constructor",
    "Enum",
    "Field",
    "Function",
    "Interface",
    "Method",
    "Module",
    "Namespace",
    -- "Package", -- remove package since luals uses it for control flow structures
    "Property",
    "Struct",
    "Trait",
  },
}

---@param buf? number
---@return string[]?
local function get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if not kind_filter then
    return
  end
  if kind_filter == false then
    return
  end
  if kind_filter[ft] == false then
    return
  end
  if type(kind_filter[ft]) == "table" then
    ---@diagnostic disable-next-line: return-type-mismatch
    return kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(kind_filter) == "table" and type(kind_filter.default) == "table" and kind_filter.default or nil
end

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

require("fzf-lua").setup()
require("fzf-lua").register_ui_select()

-- Generic
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>:", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>s.", "<cmd>FzfLua resume<cr>", { desc = "Resume" })

-- Find
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<cr>", { desc = "Config Files" })
vim.keymap.set("n", "<leader>fd", function()
  local fd_opts = require("fzf-lua").defaults.files.fd_opts
  fd_opts = ". ~/repos/dotfiles ~/repos/dotfiles-private " .. fd_opts
  require("fzf-lua").files({ fd_opts = fd_opts })
end, { desc = "Dotfiles" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Git Files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })

-- Git
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Status" })

-- Search
vim.keymap.set("n", '<leader>s"', "<cmd>FzfLua registers<cr>", { desc = "Registers" })
vim.keymap.set("n", "<leader>sa", "<cmd>FzfLua autocmds<cr>", { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Buffer" })
vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep" })
vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua helptags<cr>", { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", { desc = "Jumplist" })
vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>", { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "Jump to Mark" })
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Word" })
vim.keymap.set("v", "<leader>sw", "<cmd>FzfLua grep_visual<cr>", { desc = "Selection" })
vim.keymap.set("n", "<leader>uC", "<cmd>FzfLua colorschemes<cr>", { desc = "Colorscheme with Preview" })

-- Symbols
vim.keymap.set("n", "<leader>ss", function()
  require("fzf-lua").lsp_document_symbols({ regex_filter = symbols_filter })
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>ss", function()
  require("fzf-lua").lsp_live_workspace_symbols({ regex_filter = symbols_filter })
end, { desc = "LSP Workspace Symbols" })
