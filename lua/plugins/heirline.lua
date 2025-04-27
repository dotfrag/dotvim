return {
  "rebelot/heirline.nvim",
  enabled = vim.g.statusline == "heirline",
  event = "VeryLazy",
  dependencies = { "Zeioth/heirline-components.nvim" },
  opts = function()
    local lib = require("heirline-components.all")
    return {
      statuscolumn = { -- UI left column
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        lib.component.foldcolumn(),
        lib.component.numbercolumn(),
        lib.component.signcolumn(),
      } or nil,
      statusline = { -- UI statusbar
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.file_info({ filename = {}, filetype = false, file_modified = { padding = { left = 1 } } }),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.compiler_state(),
        lib.component.virtual_env(),
        lib.component.nav({ scrollbar = false }),
        lib.component.mode({ surround = { separator = "right" } }),
      },
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local heirline_components = require("heirline-components.all")

    heirline_components.init.subscribe_to_events()
    heirline.load_colors(heirline_components.hl.get_colors())
    heirline.setup(opts)
  end,
}
