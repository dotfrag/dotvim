local plugin_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp"
local binary_dir = plugin_path .. "/target/release"
local binary_path = binary_dir .. "/libblink_cmp_fuzzy.so"
local compile = true

vim.api.nvim_create_user_command("BlinkBinary", function()
  if compile then
    vim.notify("blink.cmp: compiling binary", vim.log.levels.INFO)
    vim.system({ "cargo", "build", "--release" }, { cwd = plugin_path, text = true }, function(obj)
      if obj.code == 0 then
        vim.notify("blink.cmp: compilation finished", vim.log.levels.INFO)
        vim.system({ "notify-send", "-t", "2500", "blink.cmp: compilation finished" })
        -- HACK: workaround for init (do not quit before init has finished)
        local first_compilation_file = vim.fn.stdpath("state") .. "/blink-binary"
        local first_compilation = not vim.uv.fs_stat(first_compilation_file)
        if first_compilation then
          local f = io.open(first_compilation_file, "w")
          if f ~= nil then
            f:close()
          end
        else
          vim.defer_fn(function()
            vim.cmd.quitall()
          end, 2500)
        end
      else
        vim.notify("blink.cmp: compilation failed", vim.log.levels.ERROR)
        vim.print(obj.stderr)
      end
    end)
  else
    vim.notify("blink.cmp: downloading pre-built binary", vim.log.levels.INFO)
    vim.fn.mkdir(binary_dir, "p")
    vim.system({
      "wget",
      "-O",
      binary_path,
      "https://github.com/Saghen/blink.cmp/releases/latest/download/x86_64-unknown-linux-gnu.so",
    }, { text = true }, function(obj)
      -- vim.schedule(function()
      if obj.code == 0 then
        vim.notify("blink.cmp: downloading complete", vim.log.levels.INFO)
      else
        vim.notify("blink.cmp: downloading failed", vim.log.levels.ERROR)
        vim.print(obj.stderr)
      end
      -- end)
    end)
  end
end, { desc = "Download latest blink pre-built binary" })

if not vim.uv.fs_stat(binary_path) then
  vim.cmd.BlinkBinary()
end

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink-cmp").setup({
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = { preset = "default" },

  completion = {
    documentation = { auto_show = true },
    menu = { scrollbar = false },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      -- lsp = { fallbacks = {} }, -- defaults to `{ 'buffer' }` (to always show the buffer source)
      lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      buffer = { -- https://github.com/nvim-lua/kickstart.nvim/pull/1642
        score_offset = -100,
        -- enabled = function()
        --   local enabled_filetypes = { "markdown", "text" }
        --   local filetype = vim.bo.filetype
        --   return vim.tbl_contains(enabled_filetypes, filetype)
        -- end,
      },
    },
  },

  -- Command line completion
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<Right>"] = false,
      ["<Left>"] = false,
    },
    completion = {
      list = { selection = { preselect = false } },
      menu = {
        auto_show = function(_)
          return vim.fn.getcmdtype() == ":"
        end,
      },
      ghost_text = { enabled = true },
    },
  },

  -- Shows a signature help window while you type arguments for a function
  signature = {
    enabled = true,
    -- window = {
    --   show_documentation = true,
    -- },
  },
})
