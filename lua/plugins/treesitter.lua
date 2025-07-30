require("nvim-treesitter").setup()
require("treesitter-context").setup()

-- https://github.com/nvim-lua/kickstart.nvim/pull/1657#issuecomment-3119533001
---@param buf integer
---@param language string
---@return boolean
local function attach(buf, language)
  -- check if parser exists before starting highlighter
  if not vim.treesitter.language.add(language) then
    return false
  end
  vim.treesitter.start(buf, language)
  -- enables treesitter based folds `:h vim.treesitter.foldexpr()`
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- enables treesitter based indentation `:h nvim-treesitter.indentexpr()`
  -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  return true
end

local exclude_parsers = { "csv", "sql", "toml" }
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)
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
    if not language then
      return
    end
    if attach(buf, language) then
      return
    end
    -- attempt to start highlighter after installing missing language
    require("nvim-treesitter").install(language):await(function()
      attach(buf, language)
    end)
  end,
})
