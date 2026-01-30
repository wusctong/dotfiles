-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>rf", function()
  require("conform").format({ async = true })
end, { desc = "clang-format" })
vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { desc = "Run Code" })
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>:bd!<CR>]], { silent = true })
vim.keymap.set("n", "<Esc><Esc>", [[:bd!<CR>]], { silent = true })
