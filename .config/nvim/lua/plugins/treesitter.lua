local config = function()
  require("nvim-treesitter.configs").setup({
    build = ":TSUpdate",
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    matchup = { enable = true },
    pairs = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    event = {

      "BufReadPre",
      "BufNewFile",
    },
    ensure_installed = {
      "markdown",
      "json",
      "scss",
      "javascript",
      "tsx",
      "rasi",
      "typescript",
      "yaml",
      "html",
      "css",
      "markdown",
      "bash",
      "lua",
      "dockerfile",
      "solidity",
      "gitignore",
      "python",
      "markdown_inline",
      "vimdoc",
      "vue",
      "diff",
      "gitignore",
      "gitcommit",
      "git_rebase",
      "git_config",
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },

    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Leader>v",
        node_incremental = "<Leader>v",
        node_decremental = "<bs>",
        scope_incremental = false,
      },
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
          ["ac"] = "@class.outer",
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = true,
      },
    },
  })
end

local dependencies = {
  {
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = true,
      check_ts = true,
      ts_config = {
        javascript = { "template_string" },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = dependencies,
  config = config,
}

