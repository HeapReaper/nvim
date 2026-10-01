-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Alt+A = left
vim.keymap.set("i", "<M-a>", "<Left>")

-- Alt+D = right
vim.keymap.set("i", "<M-d>", "<Right>")

-- Alt+W = up
vim.keymap.set("i", "<M-w>", "<Up>")

-- Alt+S = down
vim.keymap.set("i", "<M-s>", "<Down>")

-- Exit insert with alt e
vim.keymap.set("i", "<M-e>", "<Esc>")

-- Exit mode with alt e
vim.keymap.set("t", "<M-e>", [[<C-\><C-n>]])
