-- https://github.com/nvim-lua/kickstart.nvim/pull/1628

---@class util.lsp.diagnostic
local M = {}

local mode = "static"

local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚 ",
  [vim.diagnostic.severity.WARN] = "󰀪 ",
  [vim.diagnostic.severity.INFO] = "󰋽 ",
  [vim.diagnostic.severity.HINT] = "󰌶 ",
}

-- virtual text only
local function setup_static()
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    -- underline = true,
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = { text = diagnostic_icons },
    virtual_text = {
      source = "if_many",
      -- prefix = "",
      spacing = 2,
      -- apparently this is not needed (https://github.com/nvim-lua/kickstart.nvim/pull/1550)
      -- format = function(diagnostic)
      --   local diagnostic_message = {
      --     [vim.diagnostic.severity.ERROR] = diagnostic.message,
      --     [vim.diagnostic.severity.WARN] = diagnostic.message,
      --     [vim.diagnostic.severity.INFO] = diagnostic.message,
      --     [vim.diagnostic.severity.HINT] = diagnostic.message,
      --   }
      --   return diagnostic_message[diagnostic.severity]
      -- end,
    },
    -- Display multiline diagnostics as virtual lines
    -- virtual_lines = true,
  })
end

-- virtual text in insert mode and virtual lines in normal mode
-- https://github.com/nvim-lua/kickstart.nvim/pull/1628
local function setup_dynamic()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    -- underline = true,
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = { text = diagnostic_icons },
  })

  -- Diagnostic configuration similar to VS Code's Error Lens.
  -- In insert mode, diagnostics are displayed as inline virtual text.
  -- In normal mode, diagnostics are shown as virtual lines below the affected lines.
  ---@param enable boolean
  local function set_virtual_text(enable)
    vim.diagnostic.config({
      virtual_lines = not enable and {
        format = function(diagnostic)
          return (diagnostic_icons[diagnostic.severity] or "") .. diagnostic.message
        end,
      } or false,
      virtual_text = enable and {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          return (diagnostic_icons[diagnostic.severity] or "") .. diagnostic.message
        end,
      } or false,
    })
  end

  set_virtual_text(false)

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      set_virtual_text(true)
    end,
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "i:*",
    callback = function()
      set_virtual_text(false)
    end,
  })
end

local function setup_hover()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    -- underline = true,
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = { text = diagnostic_icons },
  })

  -- Diagnostic configuration similar to VS Code's Error Lens.
  -- In insert mode, diagnostics are displayed as inline virtual text.
  -- In normal mode, diagnostics are shown as virtual lines below the affected lines.
  ---@param enable boolean
  local function set_virtual_text(enable)
    vim.diagnostic.config({
      virtual_text = enable and {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          return (diagnostic_icons[diagnostic.severity] or "") .. diagnostic.message
        end,
      } or false,
    })
  end

  set_virtual_text(false)

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      set_virtual_text(true)
    end,
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "i:*",
    callback = function()
      set_virtual_text(false)
    end,
  })

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false, source = "if_many", border = "rounded" })
    end,
  })
end

function M.config()
  if mode == "static" then
    setup_static()
  elseif mode == "dynamic" then
    setup_dynamic()
  elseif mode == "hover" then
    setup_hover()
  end
end

return M
