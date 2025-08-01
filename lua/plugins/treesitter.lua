if vim.g.treesitter_new then
  return {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      branch = "main",
      dependencies = "nvim-treesitter/nvim-treesitter-context",
      config = function()
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

        local exclude_parsers = { "csv", "sql" }
        vim.api.nvim_create_autocmd("FileType", {
          callback = function(args)
            local buf, filetype = args.buf, args.match
            local language = vim.treesitter.language.get_lang(filetype)
            for _, parser in ipairs(exclude_parsers) do
              if language == parser then
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
      end,
    },
  }
else
  return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "LazyFile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "bash", "diff", "go", "html", "lua", "luadoc", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc" },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
        },
        swap = {
          enable = true,
          swap_next = { ["<leader>a"] = "@parameter.inner" },
          swap_previous = { ["<leader>A"] = "@parameter.inner" },
        },
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
  }
end
