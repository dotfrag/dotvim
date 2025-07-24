if vim.g.treesitter_new then
  return {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      branch = "main",
      config = function()
        local parsers = { "c", "bash", "diff", "html", "javascript", "lua", "luadoc", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc" }
        require("nvim-treesitter").install(parsers)

        local parser_to_ft = {
          bash = "sh",
        }

        for i, parser in ipairs(parsers) do
          if parser_to_ft[parser] then
            parsers[i] = parser_to_ft[parser]
          end
        end

        vim.api.nvim_create_autocmd("FileType", {
          pattern = parsers,
          callback = function()
            -- enbales syntax highlighting and other treesitter features
            vim.treesitter.start()

            -- enbales treesitter based folds
            -- for more info on folds see `:help folds`
            -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            -- enables treesitter based indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
