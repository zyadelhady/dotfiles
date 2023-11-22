-- return {
-- 	"EdenEast/nightfox.nvim",
-- 	lazy = false,
-- 	pioriy = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme carbonfox")
-- 	end,
--  }

return {
	"tinted-theming/base16-vim",
	lazy = false,
	piority = 1000,
	config = function()
		vim.g.base16_colorspace = 256
		vim.cmd("colorscheme base16-default-dark")
	end,
}
