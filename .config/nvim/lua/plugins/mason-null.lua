return {

  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        "protolint",
        "stylelint",
        "stylua",
        "luacheck",
        "prettierd",
        "eslint_d",
        "fixjson",
        "debugpy",
      },
      automatic_installation = true,
      handlers = {},
    })
  end,
}
