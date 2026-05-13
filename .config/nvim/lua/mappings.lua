require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { desc = "Zoxide (Recent Projects)" })

-- toggle whitespaces and such  
--
--   
map('n', '<leader>ui', function()
  vim.wo.list = not vim.wo.list
  print("invisible characters: " .. (vim.wo.list and "On" or "Off"))
end, { desc = 'toggle invisibles' })

-- lsp
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "LSP floating diagnostic" })
map("n", "<leader>da", vim.lsp.buf.code_action, { desc = "LSP code action" })

-- save with ctrl+s
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
