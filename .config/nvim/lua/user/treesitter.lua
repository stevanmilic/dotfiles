require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  incremental_selection = { enable = true },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["at"] = "@class.outer",
        ["it"] = "@class.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["al"] = "@call.outer",
        ["il"] = "@call.inner",
        ["as"] = "@statement.outer",
        ["ac"] = "@comment.outer",
      },
    },
  },
}

require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.fuse = {
  install_info = {
    url = "https://github.com/stevanmilic/tree-sitter-fuse",
    files = { "src/parser.c", "src/scanner.cc" },
  },
}
parser_config.scala = {
  install_info = {
    url = "https://github.com/stevanmilic/tree-sitter-scala",
    files = { "src/parser.c", "src/scanner.c" },
    revision = "1564db8ae938955fbd939a6ae8f543a1bfdcfa79",
  },
}
local python_folds_query = [[
    [
      (function_definition)
      (class_definition)
      (import_from_statement)
      (string)
    ] @fold
]]
require('vim.treesitter.query').set_query("python", "folds", python_folds_query)
