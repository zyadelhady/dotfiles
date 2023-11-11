local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})

	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end

	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local lspconfig = require("lspconfig")

	local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- typescript
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			typescript = {
				format = { enable = false },
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
				suggest = {
					includeCompletionsForModuleExports = true,
				},
				referencesCodeLens = { enabled = true, showOnAllFunctions = true },
				implementationsCodeLens = { enabled = true },
			},
			javascript = {
				format = { enable = false },
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
				suggest = {
					includeCompletionsForModuleExports = true,
				},
				referencesCodeLens = { enabled = true, showOnAllFunctions = true },
				implementationsCodeLens = { enabled = true },
			},
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	--html
	lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities, filetypes = { "html", "heex" } })

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"heex",
			"scss",
			"less",
			"svelte",
			"vue",
		},
	})

	-- docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		single_file_support = true,
		filetypes = { "Dockerfile", "dockerfile" },
		cmd = { "docker-langserver", "--stdio" },
		root_dir = function()
			require("lspconfig.util").root_pattern("Dockerfile")
		end,
	})

	-- elixir
	lspconfig.elixirls.setup({
		cmd = { "/home/zyad/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
		capabilities = capabilities,
		-- on_attach = on_attach,
		flags = {

			debounce_text_changes = 150,
		},
		settings = {

			elixirLS = {
				dialyzerEnabled = false,
			},
		},
	})

	-- omnisharp
	lspconfig.omnisharp.setup({
		filetypes = { "cs", "vb" },
		cmd = {
			"/home/zyad/.local/share/nvim/mason/packages/omnisharp/omnisharp",
			"--languageserver",
			"--hostPID",
			tostring(vim.fn.getpid()),
		},
		root_dir = function(fname)
			local root_patterns = { "*.sln", "*.csproj", "omnisharp.json", "function.json" }
			for _, pattern in ipairs(root_patterns) do
				local found = require("lspconfig.util").root_pattern(pattern)(fname)
				if found then
					return found
				end
			end
		end,
		enable_editorconfig_support = true,
		enable_ms_build_load_projects_on_demand = false,
		enable_roslyn_analyzers = false,
		organize_imports_on_format = true,
		enable_import_completion = false,
		sdk_include_prereleases = true,
		analyze_open_documents_only = false,
	})

	-- --- diagnostics
	vim.diagnostic.config({
		underline = false,
		update_in_insert = true,
		float = {
			source = "if_many",
		},
		virtual_text = {
			spacing = 4,
			source = "if_many",
			-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
			-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
			-- prefix = "icons",
			prefix = "󰊠 ",
			severity_sort = true,
		},
	})
end

local keys = {
	{
		mode = "n",
		"gh",
		function()
			vim.lsp.inlay_hint(0, nil)
		end,
		desc = "Toggle inlay hints",
	},
	{
		mode = "n",
		"<Leader><Leader>",
		function()
			vim.diagnostic.open_float()
		end,
		desc = "Line Diagnostics",
	},
	{
		mode = "n",
		"gtd",
		function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end,
		desc = "Go to definition",
	},
	{
		mode = "n",
		"gd",
		function()
			vim.lsp.buf.hover()
		end,
		desc = "Hover details",
	},
	{
		mode = "n",
		"d'",
		function()
			vim.diagnostic.goto_next()
		end,
		desc = "got to next diagnostic",
	},
	{
		mode = "n",
		"d;",
		function()
			vim.diagnostic.goto_prev()
		end,
		desc = "go to prev diagnostic",
	},
	{
		mode = { "n", "v" },
		"ga",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code actions provided by LSP",
	},
	{
		mode = "n",
		"<leader>r",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "Rename under cursor",
	},
	{
		mode = "i",
		"<C-k>",
		function()
			vim.lsp.buf.signature_help()
		end,
		desc = "Signature Help",
	},
	{
		mode = "n",
		"gR",
		function()
			vim.lsp.buf.references()
		end,
		desc = "Check references under cursor",
	},
}

return {
	"neovim/nvim-lspconfig",
	config = config,
	keys = keys,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
