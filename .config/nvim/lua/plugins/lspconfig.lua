local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})
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
		filetypes = {
			"typescript",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	-- solidity
	lspconfig.solidity.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
	})

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
	})

	--- diagnostics
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
		"d]",
		function()
			vim.diagnostic.goto_next()
		end,
	},
	{
		mode = "n",
		"d[",
		function()
			vim.diagnostic.goto_prev()
		end,
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
