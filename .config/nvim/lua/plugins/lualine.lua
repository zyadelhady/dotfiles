local config = function()
  require("lualine").setup({
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "codedark",
      component_separators = "|",
      section_separators = "",
    },
    section = { lualine_b = { "branch" }, lualine_c = { require("auto-session.lib").current_session_name } },
  })
end

return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  config = config,
}
