local symbols = {
  Text = "󰚞",
  Method = "󰆩",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "󱉸",
  Value = "󱢏",
  Enum = "",
  Keyword = "",
  Snippet = "󰆐",
  Color = "󰌁",
  File = "󰈔",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "󱌣",
  TypeParameter = "󰉺",
}
local borderstyle = {
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
}

return {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    {
      "onsails/lspkind.nvim",
      event = "BufReadPre",
      config = function()
        require("lspkind").init({
          mode = "symbol",
          preset = "codicons",
          symbol_map = symbols,
        })
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      opts = {
        history = true,
      },
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip").filetype_extend("js" or "jsx", { "javascript" })
          require("luasnip").filetype_extend("ts" or "tsx", { "typescript" })
        end,
      },
      keys = {
        {
          "<Tab>",
          mode = { "i", "s" },
          function()
            if require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              return "<Tab>"
            end
          end,
          expr = true,
          silent = true,
        },
        {
          "<s-Tab>",
          mode = { "i", "s" },
          function()
            if require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            end
          end,
          expr = true,
          silent = true,
        },
      },
    },
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        documentation = borderstyle,
        completion = borderstyle,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping({
          i = cmp.mapping.complete(),
          c = function(
              _ --[[fallback]]
          )
            if cmp.visible() then
              if not cmp.confirm({ select = true }) then
                return
              end
            else
              cmp.complete()
            end
          end,
        }),
        ["<C-s>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        -- ["<Tab>"] = nil,
        -- ["<S-Tab>"] = nil,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "path" },
        { name = "buffer",                 keyword_length = 5, max_item_count = 10 },
      }),
      -- formatting = {
      -- 	format = require("lspkind").cmp_format({
      -- 		mode = "symbol",
      -- 	}),
      -- },
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
          -- Define menu shorthand for different completion sources.
          local menu_icon = {
            nvim_lsp = "NLSP",
            nvim_lua = "NLUA",
            luasnip = "LSNP",
            buffer = "BUFF",
            path = "PATH",
          }
          -- Set the menu "icon" to the shorthand for each completion source.
          item.menu = menu_icon[entry.source.name]

          -- Set the fixed width of the completion menu to 60 characters.
          -- fixed_width = 20

          -- Set 'fixed_width' to false if not provided.
          fixed_width = fixed_width or false

          -- Get the completion entry text shown in the completion window.
          local content = item.abbr

          -- Set the fixed completion window width.
          if fixed_width then
            vim.o.pumwidth = fixed_width
          end

          -- Get the width of the current window.
          local win_width = vim.api.nvim_win_get_width(0)

          -- Set the max content width based on either: 'fixed_width'
          -- or a percentage of the window width, in this case 20%.
          -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
          local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

          -- Truncate the completion entry text if it's longer than the
          -- max content width. We subtract 3 from the max content width
          -- to account for the "..." that will be appended to it.
          if #content > max_content_width then
            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
          else
            item.abbr = content .. (" "):rep(max_content_width - #content)
          end
          return item
        end,
      },
    })
    vim.cmd(":set winhighlight=" .. cmp.config.window.bordered().winhighlight)
    cmp.setup.filetype("lua", {
      sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "path" },
        { name = "buffer",                 keyword_length = 5, max_item_count = 10 },
      }),
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        { name = "buffer" },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
  end,
}
