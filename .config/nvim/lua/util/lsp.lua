local mapkey = require("util.keymapper").mapkey

local M = {}

-- bravo keymaps on the active lsp server
M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end
-- set
return M
