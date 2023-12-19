vim.api.nvim_create_autocmd("VimEnter", { command = "lua require('persistence').load()" })
