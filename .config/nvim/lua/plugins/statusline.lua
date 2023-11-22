local config = function()
	require("lualine").setup({
		options = {
			globalstatus = true,
			icons_enabled = false,
			theme = "onedark",
			component_separators = "|",
			section_separators = "",
		},
		section = { lualine_b = { "branch" } },
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "UIEnter",
	config = config,
}
