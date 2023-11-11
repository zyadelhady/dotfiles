-- return {
--     'Mofiqul/vscode.nvim',
--     lazy = false,
--     priority = 999,
--  config = function()
--     vim.o.background = "dark"
--     require("vscode").setup({})
--     require("vscode").load()
--   end,
-- }
--
return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	pioriy = 1000,
	config = function()
		vim.cmd("colorscheme carbonfox")
	end,
}
