local highlight = {
    "CursorColumn",
    "Whitespace",
}

local config = function ()
  require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = true },
}
end

return { 
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  main = "ibl",
  config= config
}
