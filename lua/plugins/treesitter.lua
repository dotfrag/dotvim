require("nvim-treesitter").setup()
require("treesitter-context").setup()

-- https://github.com/nvim-lua/kickstart.nvim/pull/1657
---@param buf integer
---@param language string
local function attach(buf, language)
  -- check if parser exists before starting highlighter
  if not vim.treesitter.language.add(language) then
    return
  end
  -- enables syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)
  -- enables treesitter based folds `:h vim.treesitter.foldexpr()`
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- enables treesitter based indentation `:h nvim-treesitter.indentexpr()`
  -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- ensure parsers are installed
local ensure_installed = {
  "astro",
  "bash",
  "c",
  "desktop",
  "diff",
  "git_config",
  "gitignore",
  "html",
  "ini",
  "javascript",
  "json",
  "jsonc",
  "just",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
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
local available = require("nvim-treesitter.config").get_available()
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match
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

    -- automatically install parser for missing languages
    local installed = require("nvim-treesitter").get_installed("parsers")
    if vim.tbl_contains(installed, language) then
      -- parser is already installed -> attach
      attach(buf, language)
    elseif vim.tbl_contains(available, language) then
      -- parser is not installed but available -> install it first then attach
      require("nvim-treesitter").install(language):await(function()
        attach(buf, language)
      end)
    end
  end,
})
