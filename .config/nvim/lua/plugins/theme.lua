return {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 999,
 config = function()
    vim.o.background = "dark"
    require("vscode").setup({})
    require("vscode").load()
  end,
}