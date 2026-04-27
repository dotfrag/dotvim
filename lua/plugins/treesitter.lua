require("nvim-treesitter").setup()
require("treesitter-context").setup()

local auto_install = true

---@param buf integer
---@param language string
local function attach(buf, language)
  -- check if parser exists and load it
  if not vim.treesitter.language.add(language) then
    return
  end
  vim.treesitter.start(buf, language)

  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.wo.foldmethod = "expr"

  -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  -- check if treesitter indentation is available for this language, and if so enable it
  -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
  local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

  -- enables treesitter based indentation
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

-- ensure parsers are installed
local ensure_installed = {
  "astro",
  "bash",
  "c",
  "desktop",
  "diff",
  "git_config",
  "gitcommit",
  "gitignore",
  "html",
  "ini",
  "javascript",
  "json",
  "just",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rasi",
  "ssh_config",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zsh",
}
Util.on_vim_enter(function()
  require("nvim-treesitter").install(ensure_installed)
end)

local exclude = { "csv", "sql", "toml" }
local available_parsers = require("nvim-treesitter").get_available()
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    -- abort if language parser doesn't exist
    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    -- uninstall excluded parsers
    for _, parser in ipairs(exclude) do
      if language == parser then
        ---@diagnostic disable-next-line: param-type-mismatch
        if vim.treesitter.language.add(language) then
          vim.treesitter.stop(buf)
          require("nvim-treesitter").uninstall(language)
        end
        return
      end
    end

    -- start treesitter
    if auto_install then
      local installed_parsers = require("nvim-treesitter").get_installed("parsers")
      if vim.tbl_contains(installed_parsers, language) then
        -- enable the parser if it is installed
        attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
        require("nvim-treesitter").install(language):await(function()
          attach(buf, language)
        end)
      else
        -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        attach(buf, language)
      end
    else
      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      vim.treesitter.start(buf, language)

      -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.wo.foldmethod = "expr"

      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
