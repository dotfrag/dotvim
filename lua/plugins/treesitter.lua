require("nvim-treesitter").setup()
require("treesitter-context").setup()

-- https://github.com/nvim-lua/kickstart.nvim/pull/1657
---@param buf integer
---@param language string
---@return boolean
local function attach(buf, language)
  -- check if parser exists before starting highlighter
  if not vim.treesitter.language.add(language) then
    return false
  end
  -- enables syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)
  -- enables treesitter based folds `:h vim.treesitter.foldexpr()`
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- enables treesitter based indentation `:h nvim-treesitter.indentexpr()`
  -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  return true
end

-- ensure basic parser are installed
local ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
Util.on_vim_enter(function()
  require("nvim-treesitter").install(ensure_installed)
end)

local exclude_parsers = { "csv", "sql", "toml" }
local available_parsers = require("nvim-treesitter.config").get_available()
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    -- uninstall excluded parsers
    for _, parser in ipairs(exclude_parsers) do
      if language == parser then
        ---@diagnostic disable-next-line: param-type-mismatch
        if vim.treesitter.language.add(language) then
          vim.treesitter.stop(buf)
          require("nvim-treesitter").uninstall(language)
        end
        return
      end
    end

    if not (attach(buf, language) or vim.tbl_contains(available_parsers, language)) then
      return
    end

    -- automatically install parser for missing languages
    -- attempt to install even if it is available according to `vim.treesitter.language.add()`,
    -- to ensure the latest version is installed using `nvim-treesitter`, instead of the outdated vendored parser
    if not vim.tbl_contains(require("nvim-treesitter.config").get_installed("parsers"), language) then
      -- attempt to start highlighter after installing missing language
      require("nvim-treesitter.install").install(language):await(function()
        attach(buf, language)
      end)
    end
  end,
})
