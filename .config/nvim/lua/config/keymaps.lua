local keymap = require("util.keymapper").mapkey

local opts = { noremap = true, silent = true }

-- Pane Navigation
keymap("<C-h>", "<C-w>h", "n", opts, "go to left pane") -- Navigate Left
keymap("<C-j>", "<C-w>j", "n", opts, "go to down pane") -- Navigate Down
keymap("<C-k>", "<C-w>k", "n", opts, "go to up pane") -- Navigate Up
keymap("<C-l>", "<C-w>l", "n", opts, "go to right pane") -- Navigate Right

-- Window Management

keymap("<leader>sr", ":vsplit<CR>", "n", opts, "split to right") -- Split Vertically
keymap("<leader>sd", ":split<CR>", "n", opts, "split to down") -- Split Horizontally
keymap("<leader>wc", "<C-w>q", "n", opts, "close the pane") -- close pane
keymap("<leader>ww", "<C-w>w", "n", opts, "switch between panes") -- switch panes

-- Identing
keymap("<S-TAB>", "<gv", "v")
keymap("<TAB>", ">gv", "v")

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })
