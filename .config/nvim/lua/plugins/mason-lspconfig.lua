local opts = {
	lazy = false,
	ensure_installed = {
		"bashls",
		"ts_ls",
		"html",
		"cssls",
		"lua_ls",
		"emmet_ls",
		"jsonls",
		"elixirls",
		"jedi_language_server",
	},

	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
