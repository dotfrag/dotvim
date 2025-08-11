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
    "nvim-pack",
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

-- Highlight when yanking text
autocmd("TextYankPost", {
  group = augroup("highlight-yank"),
  callback = function()
    vim.hl.on_yank()
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
    vim.b.disable_autoformat = true
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
  group = augroup("sort-on-save"),
  pattern = { "mimeapps.list" },
  command = "%sort",
})

-- Do not automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode
autocmd("FileType", {
  group = augroup("disable-formatopt-o"),
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})
