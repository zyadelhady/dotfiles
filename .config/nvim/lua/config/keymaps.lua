local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Pane Navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
keymap("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Management

keymap("n", "<leader>sr", ":vsplit<CR>", opts) -- Split Vertically
keymap("n", "<leader>sd", ":split<CR>", opts) -- Split Horizontally
keymap("n", "<leader>wc", "<C-w>q", opts) -- close pane
keymap("n", "<leader>ww", "<C-w>w", opts) -- switch panes

-- Identing
keymap("v", "<S-TAB>", "<gv")
keymap("v", "<TAB>", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

vim.api.nvim_set_keymap("n", "<A-s>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-s>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = true })
