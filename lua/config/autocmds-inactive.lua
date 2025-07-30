local autocmd = vim.api.nvim_create_autocmd

---@param name string
local function augroup(name)
  return vim.api.nvim_create_augroup("dotvim_" .. name, { clear = true })
end

-- Navigate quickfix list without enter key
autocmd("FileType", {
  group = augroup("quickfix-navigation"),
  pattern = { "qf" },
  callback = function(event)
    vim.keymap.set("n", "j", "j<cr><c-w>p", { noremap = true, buffer = event.buf })
    vim.keymap.set("n", "k", "k<cr><c-w>p", { noremap = true, buffer = event.buf })
  end,
})

-- Go to last loc when opening a buffer (currently using mini.misc instead)
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
      -- vim.cmd([[normal! g`"zv]])
      vim.cmd.normal({ 'g`"zv', bang = true })
    end
  end,
})

-- Auto change to git root when opening a file or switching buffer (currently using mini.misc instead)
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("autocd-to-gitroot"),
  callback = function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
      return
    end -- skip unnamed buffers
    local git_root = vim.fn.systemlist("git -C " .. vim.fn.fnameescape(vim.fn.fnamemodify(filepath, ":p:h")) .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error == 0 and git_root ~= nil and git_root ~= "" then
      local current_dir = vim.fn.getcwd()
      if current_dir ~= git_root then
        vim.cmd("lcd " .. git_root)
        -- print("Changed directory to " .. git_root)
      end
    end
  end,
})

-- https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
-- Array of file names indicating root directory. Modify to your liking.
local root_names = { ".git", "Makefile" }
-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}
autocmd("BufEnter", {
  group = augroup("autocd-to-gitroot"),
  callback = function()
    -- Get directory path to start search from
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
      return
    end
    path = vim.fs.dirname(path)
    -- Try cache and resort to searching upward for root directory
    local root = root_cache[path]
    if root == nil then
      local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
      if root_file == nil then
        return
      end
      root = vim.fs.dirname(root_file)
      root_cache[path] = root
    end
    -- Set current directory
    vim.fn.chdir(root)
  end,
})

-- Close fugitive buffers when navigating
-- Probably not needed any more but leaving it here for reference
-- autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd("BufReadPost", {
  group = augroup("close-fugitive-buffers"),
  pattern = "fugitive://*",
  command = "setlocal bufhidden=delete",
})

-- Custom formatters for json files (moved to ftplugin)
autocmd("FileType", {
  group = augroup("formatters-json"),
  pattern = { "json" },
  callback = function(event)
    vim.keymap.set("n", "<leader>cq", function()
      local filepath = vim.fn.expand("%:p")
      -- stylua: ignore
      vim.cmd("silent !jq 'to_entries|sort|from_entries' " .. filepath .. " > " .. filepath .. ".tmp && mv -vi -f " .. filepath .. ".tmp " .. filepath)
    end, { buffer = event.buf, desc = "Sort JSON Keys" })
  end,
})

-- Open plugin repos with gX
-- https://github.com/dpetka2001/dotfiles/blob/main/dot_config/nvim/lua/config/autocmds.lua#L109
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("gX-github-repos"),
  callback = function()
    if vim.fn.getcwd() == vim.fn.stdpath("config") then
      vim.keymap.set("n", "gX", function()
        local uri = vim.fn.expand("<cfile>") --[[@as string]]

        -- https://github.com/neovim/neovim/blob/e3fd906b614c9ef0fdca3e456b75eae34086555b/runtime/lua/vim/_defaults.lua#L138
        local cmd, err = vim.ui.open(uri)
        local rv = cmd and cmd:wait(1000) or nil
        if cmd and rv and rv.code ~= 0 then
          err = ("vim.ui.open: command %s (%d): %s"):format((rv.code == 124 and "timeout" or "failed"), rv.code, vim.inspect(cmd.cmd))
        end

        -- custom handler
        local link = uri:match("%w[%w%-]+/[%w%-%._]+")
        if link then
          vim.ui.open("https://github.com/" .. link)
          err = nil
        end

        return err
      end, { desc = "Open filepath or URI under cursor" })
    end
  end,
})
