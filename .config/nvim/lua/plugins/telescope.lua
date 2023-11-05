return {
  {
    lazy = false,
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {
      defaults = {

        dynamic_preview_title = true,
        path_display = { "smart" },
        layout_strategy = "vertical",

        cache_picker = true,
        file_ignore_patterns = { "node_modules", ".git/" },
        preview = {
          filesize_limit = 1,
          treesitter = true,
        },
        mappings = {
          i = {
            ["<C-q>"] = "close",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
          n = {
            ["q"] = "close",
          },
        },
      },
      builtin = {
        find_files = {
          find_command = { "fd" },
          hidden = true,
          cwd_only = true,
          no_ignore = true,
        },
        diagnostics = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },
        live_grep_args = {
          find_command = { "rg", "--files" },
          auto_quoting = true,
        },
        file_browser = {
          initial_mode = "normal",
          hijack_netrw = true,
          cwd_to_path = true,
          hidden = true,
          no_ignore = false,
          select_buffer = true,
          use_fd = true,
          file_ignore_patterns = {},
          respect_gitignore = true,
          path = "%:p:h",
          dir_icon = "",
          grouped = true,
          theme = "ivy",
          prompt_path = true,
        },
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Search files",
      },
      {
        "<leader>n",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "open file browser",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "search in curenet file",
      },
      {
        "<leader>fg",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args({
            previewer = true,
          })
        end,
        desc = "Search keyword",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Show diagnostics",
      },
      {
        "<leader>fn",
        function()
          require("telescope").extensions.noice.noice({
            initial_mode = "normal",
          })
        end,
        desc = "Show notifications",
      },
      {
        "<leader>fq",
        "<cmd>DevdocsOpenFloat<CR>",
        desc = "Open floating window of documentation",
      },
    },
  },
}
