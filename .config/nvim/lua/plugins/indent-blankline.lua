local highlight = {
	"CursorColumn",
	"Whitespace",
}

local config = function()
	require("ibl").setup({
		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
			priority = 500,
			highlight = { "Function", "Label" },
		},
	})
end

return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = false,
	main = "ibl",
	config = config,
}
