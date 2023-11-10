return {
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
