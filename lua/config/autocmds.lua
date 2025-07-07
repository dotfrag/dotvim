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

-- Highlight when yanking text
autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
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

-- -- Go to last loc when opening a buffer (currently using mini.misc instead)
-- autocmd("BufReadPost", {
--   group = augroup("last-loc"),
--   callback = function(event)
--     local exclude = { "gitcommit" }
--     local buf = event.buf
--     if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].dotvim_last_loc then
--       return
--     end
--     vim.b[buf].dotvim_last_loc = true
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- -- Auto change to git root when opening a file or switching buffer (currently using mini.misc instead)
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   group = augroup("autocd-to-gitroot"),
--   callback = function()
--     local filepath = vim.api.nvim_buf_get_name(0)
--     if filepath == "" then
--       return
--     end -- skip unnamed buffers
--     local git_root = vim.fn.systemlist("git -C " .. vim.fn.fnameescape(vim.fn.fnamemodify(filepath, ":p:h")) .. " rev-parse --show-toplevel")[1]
--     if vim.v.shell_error == 0 and git_root ~= nil and git_root ~= "" then
--       local current_dir = vim.fn.getcwd()
--       if current_dir ~= git_root then
--         vim.cmd("lcd " .. git_root)
--         -- print("Changed directory to " .. git_root)
--       end
--     end
--   end,
-- })
-- -- https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
-- -- Array of file names indicating root directory. Modify to your liking.
-- local root_names = { ".git", "Makefile" }
-- -- Cache to use for speed up (at cost of possibly outdated results)
-- local root_cache = {}
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup("autocd-to-gitroot"),
--   callback = function()
--     -- Get directory path to start search from
--     local path = vim.api.nvim_buf_get_name(0)
--     if path == "" then
--       return
--     end
--     path = vim.fs.dirname(path)
--     -- Try cache and resort to searching upward for root directory
--     local root = root_cache[path]
--     if root == nil then
--       local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
--       if root_file == nil then
--         return
--       end
--       root = vim.fs.dirname(root_file)
--       root_cache[path] = root
--     end
--     -- Set current directory
--     vim.fn.chdir(root)
--   end,
-- })

-- Close fugitive buffers when navigating
-- Probably not needed any more but leaving it here for reference
-- autocmd BufReadPost fugitive://* set bufhidden=delete
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("close-fugitive-buffers"),
--   pattern = "fugitive://*",
--   command = "setlocal bufhidden=delete",
-- })
