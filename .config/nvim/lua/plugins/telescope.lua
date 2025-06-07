local keymap = vim.keymap
local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			-- winblend = 10,
			dynamic_preview_title = true,
			path_display = { "smart" },
			-- layout_strategy = "vertical",
			prompt_prefix = "    ",
			selection_caret = "  ",
			cache_picker = true,
			file_ignore_patterns = {
				".elixir_ls",
				"node_modules",
				".git/",
				"_build",
				"deps",
				"tmp",
				"cover",
				"phoenix-*.ez",
				"bin",
				"obj",
			},
			preview = {
				filesize_limit = 1,
				treesitter = true,
			},
			mappings = {
				i = {
					-- ["<C-q>"] = "send_selection_to_qflist",
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
				n = {
					["q"] = "close",
				},
			},
		},
		pickers = {
			find_files = {
				find_command = { "fdfind" },
				hidden = true,
				no_ignore = true,
				previewer = true,
			},
			diagnostics = {
				theme = "ivy",
			},
			live_grep = {
				theme = "dropdown",
				previewer = true,
			},
			buffers = {
				theme = "dropdown",
				previewer = true,
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
			refactors = {
				initial_mode = "normal",
				theme = "ivy",
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
	})
end

local dependencies = {
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
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
	"luckasRanarison/nvim-devdocs",
	opts = {
		telescope_alt = {
			theme = "dropdown",
		},
		float_win = { -- passed to nvim_open_win(), see :h api-floatwin
			relative = "editor",
			height = 50,
			width = 150,
			border = "single",
		},
		ensure_installed = { "html", "css", "javascript", "typescript" },
	},
}

local keys = {
	{
		"<leader>ff",
		function()
			require("telescope.builtin").find_files({
				layout_strategy = "horizontal",
				layout_config = { width = 0.9, height = 0.5, preview_width = 0.5, preview_cutoff = 0.1 },
			})
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
			require("telescope.builtin").current_buffer_fuzzy_find({
				layout_strategy = "horizontal",
				layout_config = { width = 0.9, height = 0.5, preview_width = 0.5, preview_cutoff = 0.1 },
			})
		end,
		desc = "search in curenet file",
	},
	{
		"<leader>fw",
		function()
			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
		end,
		desc = "Search Word Under Cursor",
	},
	{
		mode = { "v" },
		"<leader>fv",
		function()
			require("telescope-live-grep-args.shortcuts").grep_visual_selection()
		end,
		desc = "Search Word Selection",
	},
	{
		"<leader>fg",
		function()
			require("telescope").extensions.live_grep_args.live_grep_args({

				layout_strategy = "horizontal",
				layout_config = { width = 0.9, height = 0.5, preview_width = 0.5, preview_cutoff = 0.1 },
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
	{
		"<leader>fb",
		":Telescope buffers<CR>",
		desc = "Open buffers list",
	},
	{
		"<leader>gc",
		function()
			require("telescope.builtin").git_commits()
		end,
		desc = "Show git commits",
	},
	{
		"<leader>gs",
		function()
			local previewers = require("telescope.previewers")
			require("telescope.builtin").git_status({
				previewer = previewers.new_termopen_previewer({
					get_command = function(entry)
						-- this is for status
						-- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
						-- just do an if and return a different command
						if entry.status == "??" or "A " then
							return {
								"git",
								"-c",
								"core.pager=delta",
								"diff",
								entry.value,
							}
						end

						-- note we can't use pipes
						-- this command is for git_commits and git_bcommits
						return {
							"git",
							"-c",
							"core.pager=delta",
							"diff",
							entry.value .. "^!",
						}
					end,
				}),
			})
		end,
		desc = "Show git status",
	},
	{
		"<leader>gb",
		function()
			require("telescope.builtin").git_branches()
		end,
		desc = "Show git branches",
	},
}

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = "UIEnter",
	dependencies = dependencies,
	config = config,
	keys = keys,
}
