local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Pane Navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
keymap("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Management

keymap("n", "<leader>sr", ":vsplit<CR>", opts) -- Split Vertically
keymap("n", "<leader>sd", ":split<CR>", opts)  -- Split Horizontally
keymap("n", "<leader>wc", "<C-w>q", opts)      -- close pane
keymap("n", "<leader>ww", "<C-w>w", opts)      -- switch panes

-- Increase and Decrease Height
keymap("n", "<leader>hi", ":resize +2<CR>", opts)
keymap("n", "<leader>hd", ":resize -2<CR>", opts)

-- Increase and Decrease Width
keymap("n", "<leader>wi", ":vertical resize +2<CR>", opts)
keymap("n", "<leader>wd", ":vertical resize -2<CR>", opts)

-- Identing
keymap("v", "<S-TAB>", "<gv")
keymap("v", "<TAB>", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

vim.api.nvim_set_keymap("n", "<A-s>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-s>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = true })

keymap("n", "<leader>tr", "<Cmd>OverseerRun<CR>", opts)
keymap("n", "<leader>to", "<Cmd>OverseerToggle<CR>", opts)

keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap(
  "n",
  "<leader>lp",
  "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  opts
)
keymap("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
keymap("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
