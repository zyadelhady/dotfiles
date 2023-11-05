return {
  "Mofiqul/vscode.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.o.background = "dark"
    require("vscode").setup({})
    require("vscode").load()
  end,
}
