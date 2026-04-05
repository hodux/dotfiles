require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- my mappings
map("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { desc = "Zoxide (Recent Projects)" })
map('n', '<leader>ui', function()
  vim.wo.list = not vim.wo.list
  print("invisible characters: " .. (vim.wo.list and "On" or "Off"))
end, { desc = 'toggle invisibles' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
