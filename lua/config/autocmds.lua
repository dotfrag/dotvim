local autocmd = vim.api.nvim_create_autocmd

---@param name string
local function augroup(name)
  return vim.api.nvim_create_augroup("dotvim_" .. name, { clear = true })
end

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close-with-q"),
  pattern = {
    "checkhealth",
    "fugitive",
    "fugitiveblame",
    "git",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "qf",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
    end)
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last-loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].dotvim_last_loc then
      return
    end
    vim.b[buf].dotvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight when yanking text
autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = augroup("highlight-yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable autoformat for some files
autocmd("BufEnter", {
  group = augroup("disable_autoformat"),
  pattern = {
    "*/waybar/config*",
    "*/yazi/*.toml",
  },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = augroup("resize-splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Custom formatters for json files
autocmd("FileType", {
  group = augroup("formatters-json"),
  pattern = { "json" },
  callback = function(event)
    vim.keymap.set("n", "<leader>cq", function()
      local filepath = vim.fn.expand("%:p")
      -- stylua: ignore
      vim.cmd("!jq 'to_entries|sort|from_entries' " .. filepath .. " > " .. filepath .. ".tmp && mv -vi -f " .. filepath .. ".tmp " .. filepath)
    end, { buffer = event.buf, desc = "Sort JSON Keys" })
  end,
})

-- Auto sort file on save
autocmd("BufWritePre", {
  pattern = { "mimeapps.list" },
  command = "%sort",
})

-- Close fugitive buffers when navigating
-- Probably not needed any more but leaving it here for reference
-- autocmd BufReadPost fugitive://* set bufhidden=delete
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("close-fugitive-buffers"),
--   pattern = "fugitive://*",
--   command = "setlocal bufhidden=delete",
-- })
