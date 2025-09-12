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
    vim.hl.on_yank({ timeout = 250 })
  end,
})

-- Disable autoformat for some files
autocmd("BufEnter", {
  group = augroup("disable-autoformat"),
  pattern = {
    "*/waybar/config*",
    "*/yazi/*.toml",
    "wireguard-install.sh",
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

-- Auto sort file on save
autocmd("BufWritePre", {
  group = augroup("sort-on-save"),
  pattern = { ".cmds", "mimeapps.list" },
  callback = function()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.cmd.sort()
    vim.api.nvim_win_set_cursor(0, cur)
  end,
})

-- Do not automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode
autocmd("FileType", {
  group = augroup("disable-formatopt-o"),
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap-spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
