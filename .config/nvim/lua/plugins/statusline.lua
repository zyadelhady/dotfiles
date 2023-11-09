local config = function()
	require("lualine").setup({
		options = {
			  globalstatus = true,    
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
